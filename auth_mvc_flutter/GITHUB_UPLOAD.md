# رفع المشروع إلى GitHub

## الطريقة الأولى: من موقع GitHub

أنشئ مستودعًا جديدًا في GitHub، ثم فك ضغط ملف المشروع وارفع محتويات مجلد `auth_mvc_flutter` إلى المستودع. يجب أن يكون ملف `pubspec.yaml` في المستوى الرئيسي للمستودع، وليس داخل مجلد إضافي.

## الطريقة الثانية: باستخدام Git

```bash
git init
git add .
git commit -m "Initial student authentication MVC project"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

استبدل `YOUR_USERNAME` باسم حسابك و`YOUR_REPOSITORY` باسم المستودع.

بعد رفع المشروع، يستطيع أي شخص استنساخه وتشغيله عبر:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
cd YOUR_REPOSITORY
flutter pub get
flutter run
```
