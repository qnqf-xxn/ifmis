<baseImage>java</baseImage>
                    <!--安装镜像所需要的软件-->
                    <runs>
                        <!--同步 /etc/apt/sources.list 和 /etc/apt/sources.list.d 中列出的源的索引，这样才能获取到最新的软件包-->
                        <run>["apt-get","update"]</run>
                        <!--安装netcat-->
                        <run>["apt-get","-y","install","netcat"]</run>
                    </runs>

https://blog.csdn.net/AaronSimon/article/details/82711610