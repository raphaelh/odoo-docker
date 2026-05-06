FROM odoo:17

USER root

# Install zeroconf for Bonjour/mDNS discovery (required by pos_yavin)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        gnupg \
        ca-certificates \
        fonts-liberation \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libatspi2.0-0 \
        libcups2 \
        libdbus-1-3 \
        libdrm2 \
        libgbm1 \
        libgtk-3-0 \
        libnspr4 \
        libnss3 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Chromium (for headless browser features)
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl unzip && \
    ( \
        wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg && \
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
        apt-get update && \
        apt-get install -y --no-install-recommends google-chrome-stable || \
        (CHROMIUM_VERSION=$(curl -s "https://omahaproxy.appspot.com/all.json?os=linux&channel=stable" | grep -oP '"version":\s*"\K[^"]+' | head -1) && \
         CHROMIUM_REVISION=$(curl -s "https://omahaproxy.appspot.com/deps.json?version=${CHROMIUM_VERSION}" | grep -oP '"chromium_base_position":\s*"\K[^"]+' | head -1) && \
         wget -q "https://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/${CHROMIUM_REVISION}/chrome-linux.zip" -O /tmp/chrome.zip && \
         unzip -q /tmp/chrome.zip -d /opt && \
         rm /tmp/chrome.zip && \
         chmod +x /opt/chrome-linux/chrome) \
    ) && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/apt/sources.list.d/google-chrome.list || true

# Symlinks for Odoo to find Chrome
RUN if [ -f /usr/bin/google-chrome-stable ]; then \
        ln -sf /usr/bin/google-chrome-stable /usr/bin/google-chrome; \
    elif [ -f /opt/chrome-linux/chrome ]; then \
        ln -sf /opt/chrome-linux/chrome /usr/bin/google-chrome; \
    fi

# Install Python dependencies
RUN pip3 install --no-cache-dir \
    zeroconf \
    websocket-client

USER odoo
