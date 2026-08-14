Bölüm 1 - Başlangıç
    1. İncelenecek Belgeler
        1.1 https://documentation.wazuh.com/current/quickstart.html
        1.2 https://documentation.wazuh.com/current/deployment-options/docker/index.html
        1.3 https://documentation.wazuh.com/current/deployment-options/docker/wazuh-container.html
        1.4 https://documentation.wazuh.com/current/deployment-options/docker/changing-default-password.html
    2. Hazırlık
        2.1 Bilgi Edinme
            2.1.1 3 ana bileşen ve 1 yardımcı bileşen olmak üzere toplamda 4 bileşen bulunmaktadır.
                I. Wazuh server: Log kaynaklarından gelen logları karşılayan sunucu
                II. Wazuh indexer: Opensearch temelli veritabanı
                III. Wazuh dashboard: Gösterge paneli
                IV. Wazuh agent: İstemcilere/Sunuculara kurulan ve log toplama, komut çalıştırma, dosya bütünlüğü izleme güvenlik yapılandırma değerlendirme,
                    sistem envanteri, zararlı belirleme vd. görevleri yerine getiren ajan
            2.1.2 Multi-node stack: Her bir Wazuh bileşenini ayrı konteynırlar olarak konuşlandırıyor
                I. 3 Wazuh indexer: Küme olarak çalışmakta, ölçekleme ile yedeklilik sağlamaktadır.
                II. 2 Wazuh manager: 1 Master ve 1 worker olarak çalışmaktadır
                III. 1 Wazuh dashboard
                IV. 1 Nginx proxy
            2.1.3 Sistem Gereksinimleri
                I. İşletim sistemi: Linux veya Windows
                II. Mimari: AMD64 veya ARM64
                III. CPU: 4 +
                IV. Bellek: 16 GB +
                V. Disk alanı: 100 GB +
            2.1.4 Uygulama Gereksinimleri
                I. Docker motoru
                II. Docker compose
                III. Git
        2.2 İş tarifi
            2.2.1 Sistem gereksinimlerine uygun olarak Ubuntu 24.04.04 LTS VM kurulur
            2.2.2 Sunucuya ssh ile bağlanılır
                I. ssh <username>@<IP_Adres>
            2.2.3 Uygulama Gereksinimlerinin Kurulumu
                I. sudo apt/dnf install docker
                II. sudo apt/dnf install docker-compose-v2
                III. sudo apt/dnf install git
            2.2.4 Docker Gereksinimlerinin Tamamlanması
                I. Çekirdek koşma zamanı parametresinin düzenlenmesi
                    - sysctl -w vm.max_map_count=262144
                    - Ne için: Wazuh Indexer uygulamasının dosyalara doğrudan erişebilmesine olanak sağlamak için
                II. Kullanıcıya grup izni tanımlanması
                    - usermod -aG docker $USER
            2.2.5 Github deposunun klonlanması ve dizine geçilmesi
                I. git clone https://github.com/wazuh/wazuh-docker.git -b v4.14.7
                II. cd cd wazuh-docker/multi-node/
            2.2.6 Sertifikaların oluşturulması
                I. docker compose -f generate-indexer-certs.yml run --rm generator
            2.2.7 Konuşlandırmanın gerçekleştirilmesi
                I. docker compose up -d

Bölüm 2 - Süreç

    1. Sistem gereksinimlerine uygun olarak Ubuntu 24.04.04 LTS VM kurulur
    2. Sunucuya ssh ile bağlanılır
        2.1 ssh <username>@<IP_Adres>
    3.Uygulama Gereksinimlerinin Kurulumu
        3.1 sudo apt/dnf install docker
        3.2 sudo apt/dnf install docker-compose-v2
        3.3 sudo apt/dnf install git
    4. Docker Gereksinimlerinin Tamamlanması
        4.1 Çekirdek koşma zamanı parametresinin düzenlenmesi
            4.1.1 sysctl -w vm.max_map_count=262144
            4.1.2 Ne için: Wazuh Indexer uygulamasının dosyalara doğrudan erişebilmesine olanak sağlamak için
        4.2 Kullanıcıya grup izni tanımlanması
            4.2.1 usermod -aG docker $USER
    5. Github deposunun klonlanması ve dizine geçilmesi
        5.1 git clone https://github.com/wazuh/wazuh-docker.git -b v4.14.7
        5.2 cd cd wazuh-docker/multi-node/
    6. Sertifikaların oluşturulması
        6.1 docker compose -f generate-indexer-certs.yml run --rm generator
    7. Konuşlandırmanın gerçekleştirilmesi
        7.1 docker compose up -d

Bölüm 3 - Değerlendirme

    1. Süreç iş tarifinde belirtildiği gibi gerçekleşmiştir.
    2. Bu süreçte öğrendiklerim
        2.1 Logların tutulduğu veritabanı olan Wazuh Indexer'ın dosyalara RAM'deymiş gibi erişebilmesi için vm.max_map_count
        çekirdek değişkeninin öntanımlı değerinin yeterli olmadığı ve artırılması gerektiğini öğrendim.



_______________________________________


Section 1 - Inception


Section 2 - Progression


Section 3 - Evaluation


