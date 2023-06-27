#!/bin/bash
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
# Libere tráfego para interface de loopback
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#Permiti o tráfego de resposta relacionado e estabelecido 
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#Permiti o tráfego SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#Permiti o tráfego HTTP e HTTPS
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
#Permiti o tráfego DNS
iptables -A INPUT -p icmp -j ACCEPT
#Permiti o tráfego ICMP (ping)
iptables -P INPUT DROP
iptables -P FORWARD DROP
# Estabelecer política DROP para INPUT e FORWARD
echo 1 > /proc/sys/net/ipv4/ip_forward
# habilitou o redirecionamento da porta do kernel
iptables -t nat -A PREROUTING -i eth2 -p tcp --dport 80 -j DNAT --to-destination 10.1.1.10:80
#Cria uma regra de redirecionamento de porta para o HTTP (porta 80)
iptables -t nat -A PREROUTING -i eth2 -p tcp --dport 443 -j DNAT --to-destination 10.1.1.10:443
#Cria uma regra de redirecionamento de porta para o HTTPS (porta 443)
iptables -t nat -A POSTROUTING -o eth2 -s 10.1.1.0/24 -j MASQUERADE
#Configura a tradução de endereço de rede (NAT) para permitir que os pacotes de retorno alcancem os hosts internos
iptables -N LOGGING
#Cria uma nova chain para fazer o log dos pacotes
iptables -A LOGGING -m string --string "games" --algo kmp --to 65535 -j LOG --log-prefix "Blocked: " --log-level 7
#Adiciona uma regra para fazer o log dos pacotes que correspondem ao critério
iptables -A LOGGING -m string --string "games" --algo kmp --to 65535 -j DROP
#Adiciona uma regra para bloquear os pacotes que correspondem ao critério
iptables -A LOGGING -j DROP
#Configura a política padrão para a chain LOGGING
iptables -A FORWARD -p tcp --dport 80 -m state --state NEW -j LOGGING
iptables -A FORWARD -p tcp --dport 443 -m state --state NEW -j LOGGING
#Adiciona uma regra para redirecionar o tráfego HTTP e HTTPS para a chain LOGGING
nslookup www.jogosonline.com.br
#Obter o endereço IP associado ao domínio 
iptables -A FORWARD -d 127.0.0.53 -s 10.1.1.100 -j ACCEPT
iptables -A FORWARD -d 127.0.0.53 -j DROP
#Essas regras permitem explicitamente o acesso ao endereço IP do site www.jogosonline.com.br apenas a partir do endereço IP do seu chefe. Todas as outras tentativas de acesso a esse endereço IP serão bloqueadas
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/second -j ACCEPT
#Permiti que o firewall receba pacotes do tipo ICMP echo-request (ping), porém, limite a 5 pacotes por segundo.
iptables -A FORWARD -d 10.1.1.0/24 -p udp --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d 10.1.1.0/24 -p tcp --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT
#Permiti respostas DNS de entrada (rede interna)
iptables -A FORWARD -s 10.1.1.0/24 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -s 10.1.1.0/24 -p tcp --dport 53 -j ACCEPT
#Permiti consultas DNS de saída (rede interna)
iptables -A FORWARD -s 192.168.1.0/24 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -s 192.168.1.0/24 -p tcp --dport 53 -j ACCEPT
#Permiti consultas DNS de saída (DMZ)
iptables -A FORWARD -d 192.168.1.0/24 -p udp --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d 192.168.1.0/24 -p tcp --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT
#Permiti respostas DNS de entrada (DMZ)
iptables -A FORWARD -d 192.168.1.100 -p tcp --dport 80 -j ACCEPT
#Permiti o tráfego TCP destinado à máquina 192.168.1.100 (DMZ) na porta 80, vindo de qualquer rede (Interna ou Externa)
iptables -t nat -A PREROUTING -d 200.20.5.1 -p tcp --dport 80 -j DNAT --to-destination 192.168.1.100:80
iptables -t nat -A POSTROUTING -d 192.168.1.100 -p tcp --dport 80 -j SNAT --to-source 200.20.5.1
#Redirecionei os pacotes TCP destinados ao IP 200.20.5.1 porta 80, para a máquina 192.168.1.100 que está localizado na DMZ
iptables -t nat -A PREROUTING -i eth2 -p tcp --dport 80 -j DNAT --to-destination 192.168.1.100:80
#Redirecionamento de porta (PREROUTING)
iptables -t nat -A POSTROUTING -o eth1 -s 192.168.1.100 -p tcp --sport 80 -j SNAT --to-source 192.168.1.1
#Tradução de endereço de origem (POSTROUTING)

