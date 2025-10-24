curl -L -o /tmp/Dream_Stream.tar "https://github.com/Said-Pro/StalkerOS/raw/refs/heads/main/Dream_Stream.tar"
tar -xf /tmp/Dream_Stream.tar -C /tmp/
cp -r /tmp/Dream_Stream /usr/lib/enigma2/python/Plugins/Extensions/
systemctl restart enigma2
