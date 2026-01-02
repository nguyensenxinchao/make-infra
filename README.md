# make-infra

Một công cụ DevOps mã nguồn mở giúp bạn cài đặt và quản lý infrastructure services một cách dễ dàng. Chỉ cần gõ lệnh `make` để quản lý tất cả các services của bạn.

## ✨ Tính năng

- 🚀 **CLI đơn giản**: Quản lý services thông qua Makefile
- 🎨 **Web Dashboard**: Giao diện web hiện đại để quản lý services trực quan
- 🐳 **Docker Compose**: Tự động cấu hình và chạy services với Docker
- 🔒 **Best Practices**: Security, health checks, và resource limits được tích hợp sẵn
- 📊 **Real-time Status**: Theo dõi trạng thái services trong thời gian thực
- 📝 **Logs Viewer**: Xem logs của từng service ngay trên web interface

## 🛠️ Services được hỗ trợ

- **MongoDB** - NoSQL document database
- **NATS JetStream** - High-performance messaging system
- **Redis** - In-memory data structure store
- **PostgreSQL** - Advanced open-source relational database
- **MySQL** - Popular relational database
- **Elasticsearch** - Distributed search and analytics engine
- **Apache Kafka** - Distributed event streaming platform
- **RabbitMQ** - Message broker implementing AMQP

## 📋 Yêu cầu

- Docker và Docker Compose
- Make (thường đã có sẵn trên macOS/Linux)
- Node.js 18+ (cho web interface, tùy chọn)

## 🚀 Cài đặt

1. Clone repository:
```bash
git clone <repository-url>
cd make-infra
```

2. Chạy setup script:
```bash
./scripts/setup.sh
```

Hoặc kiểm tra dependencies thủ công:
```bash
./scripts/check-dependencies.sh
```

## 💻 Sử dụng CLI

### Xem help
```bash
make help
```

### Quản lý một service

**MongoDB:**
```bash
make mongodb-up        # Khởi động MongoDB
make mongodb-down      # Dừng MongoDB
make mongodb-restart   # Khởi động lại MongoDB
make mongodb-status    # Kiểm tra trạng thái
make mongodb-logs      # Xem logs
```

**NATS JetStream:**
```bash
make nats-jetstream-up
make nats-jetstream-down
make nats-jetstream-restart
make nats-jetstream-status
make nats-jetstream-logs
```

**Redis:**
```bash
make redis-up
make redis-down
make redis-restart
make redis-status
make redis-logs
```

**PostgreSQL:**
```bash
make postgres-up
make postgres-down
make postgres-restart
make postgres-status
make postgres-logs
```

**MySQL:**
```bash
make mysql-up
make mysql-down
make mysql-restart
make mysql-status
make mysql-logs
```

**Elasticsearch:**
```bash
make elasticsearch-up
make elasticsearch-down
make elasticsearch-restart
make elasticsearch-status
make elasticsearch-logs
```

**Kafka:**
```bash
make kafka-up
make kafka-down
make kafka-restart
make kafka-status
make kafka-logs
```

**RabbitMQ:**
```bash
make rabbitmq-up
make rabbitmq-down
make rabbitmq-restart
make rabbitmq-status
make rabbitmq-logs
```

### Quản lý tất cả services

```bash
make all-up       # Khởi động tất cả services
make all-down     # Dừng tất cả services
make all-status   # Kiểm tra trạng thái tất cả services
```

### Các lệnh khác

```bash
make list-services  # Liệt kê tất cả services
make check-deps      # Kiểm tra dependencies
```

## 🌐 Web Dashboard

### Khởi động web interface

```bash
cd web
npm install
npm run dev
```

Sau đó mở trình duyệt tại: http://localhost:3000

### Tính năng Web Dashboard

- 📊 **Dashboard Overview**: Xem tất cả services và trạng thái của chúng
- 🎛️ **Service Controls**: Start, stop, restart services với một click
- 📈 **Real-time Updates**: Tự động cập nhật trạng thái mỗi 5 giây
- 📝 **Logs Viewer**: Xem logs của từng service trực tiếp trên web
- 🎨 **Modern UI**: Giao diện đẹp, responsive, hỗ trợ dark mode

## 📚 Cấu hình Services

Mỗi service có folder riêng trong `services/` với:
- `docker-compose.yml`: Cấu hình Docker Compose
- `README.md`: Hướng dẫn chi tiết cho service đó
- `.env.example`: Template cho environment variables

### Tùy chỉnh cấu hình

1. Copy file `.env.example` thành `.env` trong folder service:
```bash
cd services/mongodb
cp .env.example .env
```

2. Chỉnh sửa các giá trị trong `.env` theo nhu cầu

3. Các service sẽ tự động sử dụng các giá trị từ `.env`

## 🔐 Thông tin kết nối mặc định

### MongoDB
- **Host**: localhost:27017
- **Username**: admin
- **Password**: admin123
- **Database**: myapp

### NATS JetStream
- **Client Port**: localhost:4222
- **HTTP Monitoring**: http://localhost:8222

### Redis
- **Host**: localhost:6379
- **Password**: redis123

### PostgreSQL
- **Host**: localhost:5432
- **Username**: postgres
- **Password**: postgres123
- **Database**: myapp

### MySQL
- **Host**: localhost:3306
- **Root Password**: root123
- **Database**: myapp
- **User**: appuser
- **Password**: apppass123

### Elasticsearch
- **HTTP Port**: localhost:9200
- **Transport Port**: localhost:9300

### Kafka
- **Broker**: localhost:9092
- **Zookeeper**: localhost:2181

### RabbitMQ
- **AMQP Port**: localhost:5672
- **Management UI**: http://localhost:15672
- **Username**: admin
- **Password**: admin123

> ⚠️ **Lưu ý**: Các mật khẩu mặc định chỉ dùng cho môi trường development. Hãy thay đổi chúng trong production!

## 🏗️ Cấu trúc dự án

```
make-infra/
├── Makefile                    # Main Makefile với tất cả service targets
├── docker-compose.yml          # Docker Compose cho tất cả services
├── services/                   # Service configurations
│   ├── mongodb/
│   ├── nats-jetstream/
│   ├── redis/
│   ├── postgres/
│   ├── mysql/
│   ├── elasticsearch/
│   ├── kafka/
│   └── rabbitmq/
├── web/                        # Next.js application
│   ├── app/
│   │   ├── page.tsx            # Dashboard chính
│   │   ├── api/                # API routes
│   │   └── components/         # React components
│   └── package.json
├── scripts/                    # Helper scripts
│   ├── check-dependencies.sh
│   └── setup.sh
└── README.md
```

## 🔧 Best Practices

Dự án này áp dụng các best practices sau:

### Security
- Non-root users trong containers (khi có thể)
- Network isolation giữa các services
- Secrets management thông qua environment variables

### Reliability
- Health checks cho tất cả services
- Restart policies (unless-stopped)
- Resource limits để tránh resource exhaustion

### Usability
- Clear error messages
- Progress indicators
- Dependency checks trước khi chạy

## 🤝 Đóng góp

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

MIT License - feel free to use this project for your own purposes.

## 🐛 Troubleshooting

### Docker daemon không chạy
```bash
# macOS
open -a Docker

# Linux
sudo systemctl start docker
```

### Port đã được sử dụng
Nếu port đã được sử dụng, bạn có thể:
1. Thay đổi port trong `docker-compose.yml`
2. Hoặc dừng service đang sử dụng port đó

### Service không khởi động
1. Kiểm tra logs: `make <service>-logs`
2. Kiểm tra Docker: `docker ps -a`
3. Kiểm tra disk space: `df -h`

## 📞 Hỗ trợ

Nếu bạn gặp vấn đề, vui lòng:
1. Kiểm tra [Issues](https://github.com/your-repo/issues)
2. Tạo issue mới nếu chưa có
3. Đọc documentation trong folder `services/<service-name>/README.md`

---

Made with ❤️ for the DevOps community
