export FLUTTER_HOME="/usr/local/flutter/flutter"
export PATH="$FLUTTER_HOME/bin:$PATH"

# get version code and name
time=`date +%Y%m%d`
versionCode=`git rev-list HEAD --count`
versionName=$time.$versionCode

echo '开始打包1'
echo '----- clean ----'
flutter clean
echo '----- pub get ---'
flutter pub get
#run build_runner to generate database
#flutter packages pub run jenkins_flutter  build --delete-conflicting-outputs
#generate i10n using intl_utils
#flutter pub global run intl_utils:generate
#build 
flutter build apk

#scp build/app/outputs/flutter-apk/app-debug.apk /data/outputs/debug/xmcg.apk

echo '----- 开始上传蒲公英 ---'
# 设置蒲公英的 API 参数
API_KEY="1b3d2dc183091c9bdc65c558670383e9"
IPA_PATH="build/app/outputs/flutter-apk/app-release.apk"

# 通过 cURL 上传 .ipa 文件到蒲公英
UPLOAD_RESULT=$(curl -F "file=@$IPA_PATH" -F "_api_key=$API_KEY" -F "buildInstallType=1" -F "buildType=apk" https://www.pgyer.com/apiv2/app/upload)
echo $UPLOAD_RESULT
echo '上传到蒲公英成功'
#if [[ $UPLOAD_RESULT == *"Build上传成功"* ]]; then
#    echo '上传到蒲公英成功'
#else
#    echo "上传到蒲公英失败"
#fi
