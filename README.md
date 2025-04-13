# stressWIFI
A Linux-based script to test the upper limits of a Wi-Fi router using wget, iperf3, and hping3.

This script simulates a high-load network environment to test how a home Wi-Fi router handles congestion. It uses a combination of:
 
- Massive parallel downloads with `wget`
- Bandwidth flooding via `iperf3`
- Raw traffic injection with `hping3`

## How to Use

```bash
chmod +x killwifi.sh
./killwifi.sh
