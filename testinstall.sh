#!/bin/sh
echo "=============================================="
echo "Dream Stream Installer for DreamOS"
echo "=============================================="

# تعريف المسارات
TEMP_FILE="/tmp/Dream_Stream.tar.gz"
TEMP_DIR="/tmp/Dream_Stream"
PLUGINS_DIR="/usr/lib/enigma2/python/Plugins/Extensions"

# التحقق من صلاحيات المستخدم
if [ $(id -u) -ne 0 ]; then
    echo "⚠️  يرجى تشغيل السكريبت بصلاحيات root"
    echo "استخدم: sudo ./install_dream_stream.sh"
    exit 1
fi

# التحقق من مسار الإضافات
if [ ! -d "$PLUGINS_DIR" ]; then
    echo "❌ مجلد الإضافات غير موجود: $PLUGINS_DIR"
    exit 1
fi

# تنظيف أي ملفات قديمة
echo "🧹 تنظيف الملفات المؤقتة القديمة..."
rm -rf "$TEMP_FILE" "$TEMP_DIR"

# تحميل الحزمة
echo "📥 جاري تحميل Dream Stream..."
wget -O "$TEMP_FILE" "https://github.com/Said-Pro/StalkerOS/raw/refs/heads/main/Dream_Stream.tar.gz"

# التحقق من نجاح التحميل
if [ $? -ne 0 ]; then
    echo "❌ فشل في تحميل الحزمة"
    exit 1
fi

if [ ! -f "$TEMP_FILE" ]; then
    echo "❌ الملف المحمل غير موجود"
    exit 1
fi

echo "✅ تم التحميل بنجاح"

# فك الضغط
echo "📦 جاري فك ضغط الحزمة..."
tar -xzf "$TEMP_FILE" -C /tmp/

if [ $? -ne 0 ]; then
    echo "❌ فشل في فك الضغط"
    exit 1
fi

# التحقق من وجود المجلد بعد فك الضغط
if [ ! -d "$TEMP_DIR" ]; then
    echo "❌ المجلد غير موجود بعد فك الضغط"
    exit 1
fi

echo "✅ تم فك الضغط بنجاح"

# نسخ الملفات
echo "🔄 جاري تثبيت الملفات..."
cp -r "$TEMP_DIR"/* "$PLUGINS_DIR/"

if [ $? -ne 0 ]; then
    echo "❌ فشل في نسخ الملفات"
    exit 1
fi

# منح الصلاحيات المناسبة
echo "🔒 منح الصلاحيات اللازمة..."
find "$PLUGINS_DIR" -name "*.py" -exec chmod 644 {} \;
find "$PLUGINS_DIR" -name "*.so" -exec chmod 755 {} \;
find "$PLUGINS_DIR" -name "*.sh" -exec chmod 755 {} \;

echo "✅ تم منح الصلاحيات"

# تنظيف الملفات المؤقتة
echo "🧹 تنظيف الملفات المؤقتة..."
rm -rf "$TEMP_FILE" "$TEMP_DIR"

echo "✅ تم التنظيف"

# إعادة تشغيل Enigma2
echo "🔄 جاري إعادة تشغيل Enigma2..."
systemctl restart enigma2

if [ $? -eq 0 ]; then
    echo "=============================================="
    echo "🎉 تم التثبيت بنجاح!"
    echo "📍 تمت إضافة Dream Stream إلى قائمة الإضافات"
    echo "=============================================="
else
    echo "⚠️  تم التثبيت ولكن هناك مشكلة في إعادة التشغيل"
    echo "يرجى إعادة تشغيل الجهاز يدوياً"
fi
