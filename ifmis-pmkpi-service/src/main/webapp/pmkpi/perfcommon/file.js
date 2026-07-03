if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.file = function(config, service){
    var cmp = {};
    var _mainguid = config.mainguid,
        _fudsPath = config.fudsPath,//文件服务器地址
        _basePath = config.basePath,//业务服务地址
        fl,//文件服务器对象
        _viewtype = config.viewtype,
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight
    ;
    window.parent.Ext.lt.pmkpi.childwindow = window;

    $(function () {
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        }
        (function(upload_toolbutton, upload_uidatatable){
            config.edit = true;
            config.billid = _mainguid;
            config.viewtype = _viewtype;
            config.upload_toolbutton = upload_toolbutton;
            config.upload_uidatatable = upload_uidatatable;
            fl = new Ext.lt.pmkpi.common.uploadfiles(config, service);
            var el_import = document.getElementById('新增附件');
            fl.draw(el_import);
            fl.resize(scrWidth-15,200);
            debugger
        })(toolbutton, datatable);
    })

    cmp["delFile"] = function(){
        fl.deletefile();
    }

    cmp["addFile"] = function () {

    }

    return cmp;
}