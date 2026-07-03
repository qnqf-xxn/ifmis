if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.evaluate){
    Ext.lt.pmkpi.evaluate = {};
}

Ext.lt.pmkpi.evaluate.auditservice = function(config, service) {
    var cmp = {};
    var serviceid = service;
    var mainguid = config.mainguid,
        isfileshow = config.isfileshow,
        saveAgency = config.saveAgency,
        _data = config.data,
        _filedatas = config.filedatas,
        _audittype = config.audittype,
        scrWidth = document.body.clientWidth - 20,
        scrHeight = document.body.clientHeight - 10;


    function _init() {
        var divhtml = '<div style="margin:0 auto;overflow: hidden">';
        if (isfileshow != "1") {
            divhtml += '<div id="_fileview_" style="width:' + scrWidth / 2 + 'px; height:' + (scrHeight - 40) + 'px;overflow-x: hidden;float:left;"></div>';
            divhtml += '<div style="width:' + scrWidth / 2 + 'px; height:' + (scrHeight - 40) + 'px;float:right;">';
        }
        divhtml += '<div id="_editview_" style="width:' + scrWidth / 2 + 'px; height:' + (scrHeight - 150) + 'px;"></div>';
        divhtml += '<div id="toolbtn" style="width:' + scrWidth / 2 + 'px; height:' + 50 + 'px;"></div>';
        divhtml += '</div></div>';
        $('.bd_main').append(divhtml);
        var prodiv = document.getElementById("_fileview_");
        var editview = document.getElementById("_editview_");
        editform.draw(editview);
        if (isfileshow != "1") {
            datatable.draw(prodiv);
            datatable.setDatas(_filedatas);
        }
        editform.synchEditformByObj(_data);
        // //创建下载组件
        Ext.lt.pmkpi.download = new Ext.lt.FUDSDownload();
        // //设置appid
        // Ext.lt.pmkpi.download.setAppid('pdm');
    }

    // 添加重新计算表格高度
    Ext.lt.message.hook("layout","endlayout2",function(){
        if (isfileshow != "1") {
            var tpl = Ext.lt.template;
            // 这个高度是你要显示的高度，按你需要的修改一下
            tpl.resize(datatable, (scrWidth / 2), (scrHeight - 40)); // 这三个参数，第一个是你的table的ID，改成你的ID
        }
    });

    $(function () {
        _init();
    })

    /**
     * 保存
     */
    cmp.save = function () {
        if (!editform.check()) {
            return;
        }
        var params = {};
        params.mainguid = mainguid;
        params.saveAgency = saveAgency;
        params.editinfo = editform.getEditFormValues();
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid, "saveDatas", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.ui.alert('保存成功！', function () {
                try {
                    Ext.lt.ui.closeModalWindow();
                } catch (e) {
                    parent.Ext.lt.frame.window.hide();
                }
            });
        } else {
            Ext.lt.ui.alert(rs.code, function () {
            });
        }
    }
    /**
     * 关闭页面
     */
    cmp.close = function () {
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            parent.Ext.lt.frame.window.hide();
        }
    }

    Ext.lt.message.hook("editform", "drawed", function (resp) {
        setTimeout(function () {
            var oldopinion = editform.blur();
            if (oldopinion == "") {

            }else{
                var table_eva = {
                    oldopinion: {
                        change: function (param) {
                            var opinion = param._value.text;
                            $('textarea[name="opinion"]').val(opinion);
                            //$('#textarea_1012').val(opinion);
                        }
                    },
                    audittype: {
                        /*change: function (param) {
                            var audittype = param._value.value;
                            if (audittype == "BC4E595CCE4611C7E053B11FA8C0AD52" || audittype == "BC4E595CCE4511C7E053B11FA8C0AD52" || audittype == "BCB5B04419F20765E053480A050ABEE5") {
                                Ext.lt.ui.alert("请选择前三项进行操作！",function(){
                                    $('#ts_1006').val("");
                                });
                            }
                        },*/
                        asyncloaddata: function (param) {
                            param.data = _audittype;
                        }
                    }
                }
            }
            resp.editformpanel.attachEvent(table_eva);
        },300);
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "manage"){
                col.fn = function(l,c,data,col){
                    var html = '<div style="margin-top:5px;"><img src="/pmkpi/themes/images/download.gif" title="下载" '
                        + ' style="cursor:pointer"  onclick="downfile(\'' + data.fileguid + '\',\'pdm\')" />'
                        + '</div>';
                    return html;
                }
            }
        }
    });

    return cmp;
}

function downfile(guid,appid){
    Ext.lt.pmkpi.download.setAppid(appid);
    //设置下载文件的guid
    Ext.lt.pmkpi.download.setFileGuid(guid);
    //直接下载，以ie对话框方式保存
    Ext.lt.pmkpi.download.download();
}