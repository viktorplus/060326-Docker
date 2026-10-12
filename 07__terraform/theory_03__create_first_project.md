### Создание корзины S3 с помощью terraform

#### 1. Создаём рабочую директорию `terraform_example_S3`

#### 2. Проверка наличия учетных данных: `ls -al ~/.aws/`

#### 3. (Опционально) Устанавливаем плагин в PyCharm для работы с terraform

#### 4. Создаём конфигурации Terraform `main.tf`:

```terraform
provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "bar-060326-ptm"
}
```

#### 5. Запускаем `terraform init`

```text
terraform init
Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v6.68.0...
- Installed hashicorp/aws v6.68.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.                                                                                                                     
                                                                                                                                     
If you ever set or change modules or backend configuration for Terraform,                                                            
rerun this command to reinitialize your working directory. If you forget, other                                                      
commands will detect it and remind you to do so if necessary.        
```

Команда `terraform init` создаёт или настраивает два основных элемента:

- `.terraform/` — служебный каталог. 
  - Хранит загруженные провайдеры и другие данные, необходимые Terraform для работы.
  - В нашем файле описан провайдер `aws`, `terraform init` загрузил именно его:
    - `/terraform_example_S3/.terraform/providers/registry.terraform.io/hashicorp/aws`

- `.terraform.lock.hcl` — файл блокировки версий провайдеров. 
  - фиксирует выбранную версию провайдера и контрольные суммы его пакета.
    
    ``` 
    # This file is maintained automatically by "terraform init".
    # Manual edits may be lost in future updates.
    
    provider "registry.terraform.io/hashicorp/aws" {
      version = "6.68.0"
      hashes = [
        "h1:79hHQtjGSCiXBZK+VDiNUdI2SLXbNaHf+CHySvKFnvA=",
        "zh:064ed007a33a22d8367db88b18d56a4dd066f07f95b1a4d80ffa2b6ee803f6f0",
        "zh:20ede4bb730b55023ad426ed13b1b4b295fac4bcc2baa4fb63d2932aa15d760d",
        "zh:490cffbc315ba21f740158a6b4195e7707ec2ee7ed357a47bb90ed18466f01a2",
        "zh:7840197f73f53d676373c9aeabccd79c61c6da6e4aa1ed840e57ca46c1894126",
        "zh:889b15a5c2f7fb168c04c846e75932a6b2ceb7967c3bfa0a0e24be16cdee7969",
        "zh:96ba7624b6f0e0a1fa5477b0838194be919d815d30ce7f97e04d4520cca4c00b",
        "zh:9b12af85486a96aedd8d7984b0ff811a4b42e3d88dad1a3fb4c0b580d04fa425",
        "zh:9b41c2afe2fec1a1880f9427b3ca611abfe6643b41942556a83cd7daae55acf1",
        "zh:a83e9d46de040fa7bc56f7aa53bdeb8d7078bac65d9155b07022fd75723308b8",
        "zh:aa5cfdd2faf8a2848c72c13ca88786b857fd397aa713967b8b1f9610f2c76a0b",
        "zh:abd449fbf38cf828b8b17bc8540752733dd861160504a45b411e72e1792c758c",
        "zh:b2511842cb6b23036c72babbaf12b4984835bb2824f938882330b51c68bdaecd",
        "zh:c11e8860c4d611dda93da2e5be27c9bd2599da6ad320f3d12ccc714ffbe6f100",
        "zh:e4252ceda8641bfe85ad7710b428f994c080bde6c55043ab47a08015432cebdc",
        "zh:f292ad91c97ac7354a04a698f346c2a0c3866d9170ca45dda6a6bfab71180be0",
        "zh:f4d293cd0e9562bfa1ba32a1fe5c3652c6a32b951e44081158737d4075696045",
      ]
    }
    ```

Кроме того, команда загружает необходимые провайдеры и модули.

**ВАЖНО**: команда `terraform init` **НЕ**:
- создаёт S3-бакет в AWS.
- создаёт другие ресурсы инфраструктуры.
- применяет изменения, описанные в main.tf.

#### 6. Выполняем команду `terraform plan`

Это команда: 
- анализирует конфигурацию Terraform 
- и показывает какие надо выполнить изменения в инфраструктуре, чтобы получить описанный в конфигурации результат.

**ВАЖНО**: команда `terraform plan` 
- **ТОЛЬКО** показывает предполагаемые изменения, 
- но их **НЕ** применяет.

```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.my_bucket will be created
  + resource "aws_s3_bucket" "my_bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "bar-060326-ptm"
      + bucket_domain_name          = (known after apply)
      + bucket_namespace            = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_region               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = "eu-central-1"
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
        . . .
    }

Plan: 1 to add, 0 to change, 0 to destroy.

```
То есть:
* будет создана корзина `bar-060326-ptm`
* в регионе `eu-central-1`
* и при этом ничего не будет изменено или удалено (`force_destroy = false`)

#### 7. Если нас устраивает план, то мы его применяем `terraform apply`

Система переспросит, действительно будем создавать перечисленное.

Ответить надо `yes`.

```
  Enter a value: yes

aws_s3_bucket.my_bucket: Creating...
aws_s3_bucket.my_bucket: Creation complete after 1s [id=bar-060326-ptm]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.                                                                          
```

#### 8. Проверить результат мы можем не заходя на сайт AWS

```bash
aws s3 ls
```

```
2026-10-11 22:11:51 bar-060326-ptm
```

#### 9. Важное изменение: появился файл `terraform.tfstate`

```txt
{
  "version": 4,
  "terraform_version": "1.16.5",
  "serial": 1,
  "lineage": "f9030467-ccf6-8f5d-4e74-b36c5d7c95fc",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_s3_bucket",
      "name": "my_bucket",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
  . . .
```

**Что содержит `terraform.tfstate`?**
- JSON-снимок текущего состояния инфраструктуры, которой управляет Terraform.
- Соответствие «ресурс в коде (.tf) → реальный объект в облаке» (ID, ARN и т.д.).
- Все атрибуты ресурсов, зависимости между ними, outputs, версию Terraform и провайдеров.
- Часто содержит секреты (пароли, ключи) в открытом виде.
  - (Рекомендуется добавить `*.tfstate*` в `.gitignore`).

**Что позволяет?**
- Понимать, какие ресурсы уже созданы.
- Не пересоздавать то, что уже есть.
- Ускорять работу: не опрашивать всё облако целиком.

**Защита от дубликатов**
- Terraform не создаёт заново то, что уже есть в state.

**Чего не позволяет?**
- Не защищает от ресурсов, созданных вручную или вне Terraform: 
  - он их не видит, пока их не импортируют.
- Не безопасен для хранения в Git: там могут оказаться секреты.


#### 10. Удаление созданного ресурса `terraform destroy`

**ВАЖНО**: удалено будет только то, что описано в `terraform.tfstate`

Если ранее были созданы другие корзины, то их придётся удалять отдельно.

```
terraform destroy
aws_s3_bucket.my_bucket: Refreshing state... [id=bar-060326-ptm]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.my_bucket will be destroyed
  - resource "aws_s3_bucket" "my_bucket" {
      - arn                         = "arn:aws:s3:::bar-060326-ptm" -> null
      - bucket                      = "bar-060326-ptm" -> null
      ...
  
Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_s3_bucket.my_bucket: Destroying... [id=bar-060326-ptm]
aws_s3_bucket.my_bucket: Destruction complete after 1s

Destroy complete! Resources: 1 destroyed.
```

#### 11. На всякий случай проверяем

```
aws s3 ls
```

(В списке не должно быть `bar-060326-ptm`)


#### 12. После удаления создался файл `terraform.tfstate.backup`

`terraform.tfstate.backup` — это автоматическая резервная копия предыдущего состояния,  
которую Terraform создаёт перед каждым изменением `terraform.tfstate`.

**Зачем он нужен?**

- Для страховки: 
  - если при apply/destroy state повредится или операция прервётся, можно откатиться к прошлой версии.

**Как использовать?**

- Если бакет всё ещё существует, а state пуст, можно вернуть запись о нём:
  - `cp terraform.tfstate.backup terraform.tfstate`


**Важно**:

- Это только одна последняя копия: при каждой новой операции она перезаписывается.
- Содержит секреты так же, как и основной state, поэтому его опасно коммитить в Git 
  - (Рекомендуется добавить `*.tfstate*` в `.gitignore`).