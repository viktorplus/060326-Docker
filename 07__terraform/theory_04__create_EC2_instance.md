## Создание EC2 инстанса

Для более сложного примера нам будет полезна структура, которая хранится здесь:

[https://github.com/it-career-hub/terraform-100](https://github.com/it-career-hub/terraform-100)

Полезно склонировать себе в отдельную директорию.  
(но `main.tf` лучше взять отсюда)

### Изменяем содержимое файлов

**Содержимое директории:**
- `main.tf` (не меняем): 
  - Основной конфигурационный файл, который описывает ресурсы AWS, например EC2-инстанс

- `variables.tf` (не меняем): 
  - Объявление переменных, используемых для параметризации конфигурации

- `.terraform.tfvars`: 
  - Файл, содержащий значения переменных, таких как VPC ID, подсети, размер инстансов и др.

    ```
    vpc_id = "vpc-0577810ca30dce4ee"            # VPS -> VPCs
    
    vpc_public_subnets = [                      # VPS -> Subnets
      "subnet-061be1cfde7bd1034",
      "subnet-0e088161ff49bb7bd",
      "subnet-0c20acc29548e92df"
    ]
    
    ec2_size = "t3.micro"                       # EC2 > Instances > Launch an instance
    
    volume_size = 8                             # не меняем
    
    sg_name = "terraform-sg"                    # не меняем
    
    ssh_key_name = "AWS_key"                    # ls ~/.ssh
    
    instance_name_tag = "tf-060326-ptm-bar"     # tf-grouop-name
    ```

- `outputs.tf` (не меняем): 
  - Определяет выводы (outputs), такие как публичный IP-адрес инстанса после создания

- `providers.tf`: 
  - Описание провайдеров, таких как AWS, и их конфигурация 
  - (в примере данные для Франкфурта)

    ```
    provider "aws" {
       region  = "eu-central-1"
     }
    ```

- `install_ec2_docker.sh` (не меняем): 
  - Скрипт для установки Docker на EC2-инстансе, который передается через `user_data`


### Выполняем команды

* `terraform init`

* `terraform plan -var-file=".terraform.tfvars"`

> Здесь нужно указать имя файла, откуда берём значения переменных: -var-file=".terraform.tfvars"

* `terraform apply -var-file=".terraform.tfvars"`

>Должно получиться что-то вроде этого:
>```text
>public_availability_zone = "eu-central-1b"                                                                                           
>public_instance_id = "i-012fbac7352e646e5"
>public_ip = "3.72.255.134"
>```

* Заходим на только что созданный сервер:

> ssh -i ~/.ssh/AWS_key.pem ec2-user@3.72.255.134

* И проверяем версию докера

> docker --version

* `terraform destroy -var-file=".terraform.tfvars"`

> Удаляем всё, что создали (и инстанс, и группу):  

>   Enter a value: yes  
> aws_instance.ec2_public: Destroying... [id=i-012fbac7352e646e5]  
> aws_instance.ec2_public: Still destroying... [id=i-012fbac7352e646e5, 00m10s elapsed]  
> aws_instance.ec2_public: Still destroying... [id=i-012fbac7352e646e5, 00m20s elapsed]  
> aws_instance.ec2_public: Destruction complete after 20s  
> aws_security_group.allow_ssh_pub: Destroying... [id=sg-0d9087f323bd5a3ec]  
> aws_security_group.allow_ssh_pub: Destruction complete after 1s  
> Destroy complete! Resources: 2 destroyed.   