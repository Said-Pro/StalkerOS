# الانتقال للمجلد المؤقت
cd /tmp

# فك الضغط ومشاهدة المحتويات
tar -xzf Dream_Stream.tar.gz
ls -la

# إذا رأيت مجلد Dream_Stream
cp -r Dream_Stream/* /usr/lib/enigma2/python/Plugins/Extensions/

# أو إذا كانت الملفات مباشرة
cp -r * /usr/lib/enigma2/python/Plugins/Extensions/

# ثم إعادة التشغيل
systemctl restart enigma2
