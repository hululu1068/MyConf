# Linux 部署 QuickFile（systemd + Nginx）

本目录提供一套最小可用部署方案：在 Linux 上运行 `quickfile`，并由 Nginx 反向代理。

## 文件说明

- `quickfile.service`：QuickFile 的 systemd 服务文件
- `nginx.quickfile.conf`：Nginx 的反代 `location` 片段

## 默认约定

- 二进制路径：`/usr/local/bin/quickfile`
- Socket 路径：`/run/quickfile/quickfile.sock`
- 管理目录：`/home/jack/`
- URL 前缀：`/quickfile/`
- QuickFile 登录账号：`jack`
- QuickFile 登录密码：`Jack10087`

如有需要可按实际环境修改。

## 1. 安装二进制

```bash
sudo cp ./quickfile.x86_64 /usr/local/bin/quickfile
sudo chmod +x /usr/local/bin/quickfile
```

如服务器是 ARM 架构，请改用对应架构的二进制文件。

## 2. 目录权限说明（已改为 `jack` 用户运行）

本方案中 `quickfile.service` 以 `jack` 用户运行。  
因此 QuickFile 访问 `/home/jack/` 时，默认就继承 `jack` 自身权限，通常不需要再额外配置 ACL。

可用下面命令确认目录权限：

```bash
ls -ld /home/jack
```

## 3. 安装并启动 systemd 服务

```bash
sudo cp deployquickfile.service /etc/systemd/system/quickfile.service
sudo systemctl daemon-reload
sudo systemctl enable --now quickfile
sudo systemctl status quickfile --no-pager
```

说明：此服务文件已启用 QuickFile 内置 Basic Auth（`-user/-pass`）。  
你可以在 `deploy/quickfile.service` 里改成自己的账号和密码后再部署。

## 4. 配置 Nginx

你当前 Nginx 使用自定义 `server`（`[::]:10087`）。  
请将 `nginx.quickfile.conf` 中的 `location` 片段粘贴到现有 `server { ... }` 中，然后执行：

```bash
sudo nginx -t
sudo systemctl reload nginx
```

## 5. 访问地址

- `http://<你的域名或IP>:10087/quickfile/`

## 6. 故障排查

```bash
sudo journalctl -u quickfile -f
sudo ls -l /run/quickfile/quickfile.sock
sudo nginx -t
getfacl /home/jack | sed -n '1,120p'
```

重点检查：

- `quickfile` 进程是否正常运行
- Nginx 是否能访问 `/run/quickfile/quickfile.sock`
- `systemd` 启动参数中的 URL 前缀与 Nginx location 是否一致
- `jack` 是否对 `/home/jack/` 具有实际读写权限

如果 Nginx 日志出现连接 socket 失败（如 `permission denied`），可执行：

```bash
sudo usermod -aG jack www-data
sudo systemctl restart quickfile
sudo systemctl restart nginx
```

如果访问 `/quickfile/` 返回 `{"error":"invalid host"}`，说明请求里缺少 `host` 参数。  
建议使用“内部 rewrite”方式自动补齐（避免 CDN 把外部 302 改写成 `:10087`）：

```nginx
location = /quickfile {
    rewrite ^ /quickfile/ last;
}

location ^~ /quickfile/ {
    set $qf_proto $scheme;
    set $qf_host $http_host;
    if ($http_x_forwarded_proto != "") { set $qf_proto $http_x_forwarded_proto; }
    if ($http_x_forwarded_host != "") { set $qf_host $http_x_forwarded_host; }
    if ($arg_host = "") {
        rewrite ^ /quickfile/?host=$qf_proto://$qf_host last;
    }
}
```

## 安全建议

- 公网暴露时建议增加认证（Nginx Basic Auth、SSO 或仅内网访问）
- 建议启用 HTTPS
