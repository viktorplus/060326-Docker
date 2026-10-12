[Официальный сайт](https://developer.hashicorp.com/terraform/install)

---

## Windows

1. Скачать последнюю версию c официального сайта: [https://developer.hashicorp.com/terraform/install#windows](https://developer.hashicorp.com/terraform/install#windows)
   * для `AMD64` последняя версия на 10.10.2026: [https://releases.hashicorp.com/terraform/1.16.5/terraform_1.16.5_windows_amd64.zip](https://releases.hashicorp.com/terraform/1.16.5/terraform_1.16.5_windows_amd64.zip)

2. Открыть gitBash и перейти в загрузки: `cd ~/Downloads`

3. Распаковать загруженный архив: 
   ```
   unzip ~/Downloads/terraform_*_windows_amd64.zip
   ```

4. Создать директорию для Terraform: `mkdir /c/terraform/`

5. Переместить исполняемый файл в новую директорию: `mv ~/Downloads/terraform.exe /c/terraform/`

6. Добавить Terraform в системный путь: 
   ```
   echo 'export PATH="$PATH:/c/terraform"' >> ~/.bashrc
   source ~/.bashrc
   ```

---

## MacOS

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

---

## Ubuntu

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

---

## Проверка установки для всех трёх операционных систем

```bash
terraform --version
```

Должно быть что-то вроде этого:
```
Terraform v1.16.5
on linux_amd64
```