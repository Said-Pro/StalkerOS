cat > /tmp/install_dream_stream.sh << 'EOF'
#!/bin/sh

echo "========================================"
echo "   Dream Stream Installer for Dreambox"
echo "========================================"

# المسارات
TEMP_DIR="/tmp"
PLUGIN_DIR="/usr/lib/enigma2/python/Plugins/Extensions"
PLUGIN_URL="https://github.com/Said-Pro/StalkerOS/raw/refs/heads/main/Dream_Stream.tar"

# التحقق من الصلاحيات
if [ $(id -u) -ne 0 ]; then
    echo "⚠️  يرجى تشغيل السكريبت كـ root!"
    exit 1
fi

# الانتقال للمسار المؤقت
cd $TEMP_DIR

# تحميل البلوجين
echo "📥 جاري تحميل البلوجين..."
wget -O $TEMP_DIR/Dream_Stream.tar "$PLUGIN_URL"

if [ $? -ne 0 ]; then
    echo "❌ فشل في تحميل البلوجين!"
    exit 1
fi

# فك الضغط
echo "📦 جاري فك الضغط..."
tar -xf $TEMP_DIR/Dream_Stream.tar -C $TEMP_DIR/

if [ $? -ne 0 ]; then
    echo "❌ فشل في فك الضغط!"
    exit 1
fi

# نسخ البلوجين
echo "📁 جاري تثبيت البلوجين..."
if [ -d "$TEMP_DIR/Dream_Stream" ]; then
    cp -r $TEMP_DIR/Dream_Stream $PLUGIN_DIR/
else
    echo "❌ مجلد البلوجين غير موجود بعد فك الضغط!"
    exit 1
fi

# تعديل الصلاحيات
echo "🔒 جاري تعديل الصلاحيات..."
chmod -R 755 $PLUGIN_DIR/Dream_Stream/
chown -R root:root $PLUGIN_DIR/Dream_Stream/

# تنظيف الملفات المؤقتة
echo "🧹 جاري التنظيف..."
rm -f $TEMP_DIR/Dream_Stream.tar
rm -rf $TEMP_DIR/Dream_Stream

echo "✅ تم التثبيت بنجاح!"
echo "🔄 يرجى إعادة تشغيل enigma2:"
echo "   systemctl restart enigma2"
echo "   أو"
echo "   killall -9 enigma2"

echo "========================================"
EOF
