# 🚀 CacheKiller - Linux System Cleaner  

A simple yet powerful **Linux system cleaner** script to remove junk files and free up disk space efficiently.  

---

## 🔧 Features & Functions  

### 🧹 Cleanup Operations:  

#### **Autoremove & Autoclean**  

```bash
apt autoremove -y  
apt autoclean -y  
apt clean -y  
```
- Removes unused dependencies, cleans package cache.  

#### **Old Kernel Cleanup**  

```bash
dpkg --purge
```
- Deletes unused kernel packages.  

#### **Thumbnail Cache Cleanup**  

```bash
rm -rf ~/.cache/thumbnails/*
```
- Frees up space by removing cached thumbnails.  

#### **System Logs Cleanup**  

```bash
journalctl --vacuum-size=100M
```
- Shrinks system logs to a manageable size.  

---

## ✅ Trust & Security  

- **No Viruses, No Spam:** Open-source, safe, and thoroughly tested.  
- **Uses Only System Commands:** Relies on trusted Linux utilities.  
- **Runs as Root for Full Cleanup:** Requires `sudo` for deeper cleaning.  
- **Transparency:** View the source code [here](https://github.com/Abhishek88788/cachekiller).  

For more details on the commands used, check:  
- [APT Cleanup Guide](https://linux.die.net/man/8/apt-get)  
- [Journalctl Logs](https://man7.org/linux/man-pages/man1/journalctl.1.html)  
- [DPKG Package Management](https://linux.die.net/man/1/dpkg)  

---

## 📥 Installation & Usage  

### 🔽 Download the Script  

```bash
wget https://raw.githubusercontent.com/Abhishek88788/cachekiller/main/cleaner.sh  
chmod +x cleaner.sh  
```

### 🚀 Run the Script  

```bash
sudo ./cleaner.sh  
```

### 📌 Install as a System-wide Command  

```bash
sudo mv cleaner.sh /usr/local/bin/cachekiller  
sudo chmod +x /usr/local/bin/cachekiller  
```

Now, run it from anywhere:  

```bash
sudo cachekiller  
```

---

## ⚡ Notes  

- The script displays **before & after memory usage**.  
- Supports **interactive & silent modes** (`sudo cachekiller -s` for silent mode).  
- **Estimated Execution Time:** \~10-30 seconds depending on system state.  

---

🔗 **Contribute & Report Issues**: [GitHub Issues](https://github.com/Abhishek88788/cachekiller/issues)  

🎉 **Enjoy a Cleaner Linux System!**
