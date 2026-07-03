@echo off
set /p password=请输入你的数据库密码，然后回车
echo 数据库密码：%password%
java -cp druid-1.1.13.jar com.alibaba.druid.filter.config.ConfigTools %password%

pause