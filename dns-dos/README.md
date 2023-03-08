# DNS DoS

## Setup

1. Copy netplan config for DNS backend service

    ```
    cp 99-dns.yaml /etc/netplan/
    ```

2. Apply new config

    ```
    sudo netplan apply
    ```

3. Deploy DNS container

    ```
    docker compose up -d
    ```

4. Load BIG-IP configuration

    ```
    tmsh load sys config merge from-terminal
    ```

    Paste `bigip.conf` content.
    Add a newline and press ctl-D.

5. Go to client VM & create dnsperf container

    ```
    docker run -it --name dnsperf nicolaka/netshoot sh
    ```

6. Install dnsperf inside the container

    ```
    apk update
    apk add dnsperf
    ```

7. Create dnsperf test file

    ```
    echo "api.example.com a" > query.txt
    ```

## Creating baseline

1. Create baseline

2. Attack

    ```
    dnsperf -s 10.1.10.53 -d query.txt -c 30 -T 30 -t 30 -l 300 -q 30000 -S 1 -Q 20000
    ```

## Tools

1. https://github.com/bartlomiejjanik1/l3l4ddos
2. For low and slow you could use slowloris and/or slowhttptest
3. For flooding you can use ab or siege
4. Buffer overflow you cloud use nikto