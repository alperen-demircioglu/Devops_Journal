# Mistake Log

I record the mistakes I make during mock exams, Killer.sh, or labs here. I read this file before every review session.

Add an entry by running `./mistake.sh`. It asks the questions and appends the row.

| Date | Source | Topic | Mistake → Fix |
|------|--------|-------|---------------|
| 2026-10-09 | KK Beginners M2 quiz | CRI / OCI | CRI açılımını 'Container Runtime Initiative' dedim → Container Runtime Interface (kubelet ile runtime arasındaki arayüz); OCI = Open Container Initiative (image spec + runtime spec) |
| 2026-10-09 | KK Beginners M2 quiz | crictl / ctr / nerdctl | Log komutunu ve araç ayrımını bilmedim → crictl logs <id>; ctr = sadece debug, prod için değil; nerdctl = Docker benzeri CLI |
| 2026-10-09 | KK Beginners M2 quiz | K8s architecture | Worker node bileşenlerini yazmadım, controller/scheduler tanımı eksikti → worker: kubelet + kube-proxy + container runtime; scheduler pod'u hangi node'a gideceğine karar verir; kube-controller-manager controller'ları çalıştırır |
