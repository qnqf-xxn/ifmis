if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.problemtasklist) {
    Ext.lt.pmkpi.problemtasklist = {};
}

var editwindow = null; //下达的任务接口
var _selectedtree = null;
var height;
var width;
Ext.lt.pmkpi.problemtasklist = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _saveAgency = config.saveAgency,
        _pagetype = config.pagetype,//页面类型，下达：issue、反馈：feedback、反馈审核：audit、延期审核：delayaudit
        _tabhidtbtn,//右侧页签隐藏按钮
        _tablecode,
        _tabcode,
        _defquery,
        _uikey,
        _tabfilter,//页签查询条件
        _queryConfig, //查询区配置
        _querySql;
    var serviceid = service;
    height = Math.floor(document.documentElement.clientHeight * 0.9);
    width =  Math.floor(document.documentElement.clientWidth * 0.9);
    var isfirst = true;

    Ext.lt.pmkpi.query = function () {
        Ext.lt.ui.loadingShow();
        var params = {};
        params.workflow = _workflow;
        params.menuid = _menuid;
        params.pagetype = _pagetype;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = _querySql;
        params.tablecode = _tablecode; //视图名称
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.tabcode = _tabcode; //页签编码
        params.beanid = "pmkpi.probleamtask.ProblemTaskBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("perfcommon", "tablequery", function () {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        Ext.lt.pmkpi.query();
    });

    /**
     * 下达-新增
     */
    cmp.add = function (obj) {
        var params = {};
        params.tablecode = _tablecode;
        params.saveAgency = _saveAgency;
        params.mainguid = createUUID().replace(/-/g, '');
        var url = _uikey + ".page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, width, height, "整改问题详情");
    }

    /**
     * 下达-修改
     */
    cmp.update = function (obj) {
        var data = datatable.getSelected();
        if (data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行修改！", function () {
            });
            return;
        }
        var params = {};
        params.tablecode = _tablecode;
        params.mainguid = data[0].guid;
        var url = _uikey + ".page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, width, height, "整改问题详情");
    }

    /**
     * 下达-删除
     */
    cmp.del = function (obj) {
        var params = {};
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！', function () {
            });
            return;
        }
        Ext.lt.ui.confirm("是否删除已选择数据？", null, function (is) {
            if (is) {
                params.selDatas = datas;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "del", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除成功！', function () {
                        Ext.lt.pmkpi.query();
                    });
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！', function () {
                    });
                });
            }
        })
    }

    /**
     * 下达-下达/撤回
     */
    cmp.issue = function (obj) {
        var datas = datatable.getSelected();
        var actionname = obj.name;
        var actioncode = obj.code;
        var params = {};
        params.datas = datas;
        params.pagetype = _pagetype;
        params.actioncode = obj.code;
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要'+ actionname +'的数据！', function () {
            });
            return;
        }
        var message = "是否"+ actionname +"已选择数据？";
        if(actioncode == "cancelissue"){
            var pro_name="";
            var rs = Ext.lt.RCP.asyncall(serviceid, "getreportdatas", params);
            var reportdatas = rs.reportdatas;
            if(reportdatas.length > 0){
                for (var i=0; i<reportdatas.length; i++) {
                    pro_name += reportdatas[i].name+"、"; //项目名称
                }
            }
            if (pro_name != null && pro_name != ""){
                pro_name = pro_name.substring(0,pro_name.length-1);
                message = pro_name+" 已填报，\r\n是否确认撤回？";
            }
        }
        Ext.lt.ui.confirm(message, null, function (is) {
            if (is) {
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "issue", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(actionname +'成功！', function () {
                        Ext.lt.pmkpi.query();
                    });
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(actionname +'失败！', function () {
                    });
                });
            }
        });
    }

    /**
     * 反馈-申请延期
     */
    cmp.senddelay = function (obj) {
        var datas = datatable.getSelected();
        var actionname = obj.name;
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要'+ actionname +'的数据！', function () {
            });
            return;
        }
        if (!cmp.checklistdatas("senddelay"," 正在延期申请审批中，请不要重复申请！")) return false;
        editwindow.show();
        if(datas.size() == 1){
            editform.synchEditformByObj(datas[0]);
            editform.show(['rectify_time'],false);
        } else {
            editform.hide(['rectify_time'],false);
        }
        editform.clear("extension_time");
        editform.clear("extension_reason");
    }

    /**
     * 反馈-申请延期编辑区提交.
     */
    Ext.lt.message.hook("submit", "sendeditform", function (rs) {
        if (!editform.check()) return false;//先校验
        var datas = datatable.getSelected();
        var params = {};
        params.actioncode = "senddelay";
        params.selDatas = datas;
        params.infodata = editform.getEditFormValues();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "delayupdate", params, function (rs) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('申请延期成功！', function () {
                editwindow.hide();
                Ext.lt.pmkpi.query();
            });
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('申请延期失败！', function () {
            });
        });
    });

    /**
     * 延期审核/退回/撤回
     */
    cmp.delay = function (obj) {
        var datas = datatable.getSelected();
        var actionname = obj.name;
        var actioncode = obj.code;
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要'+ actionname +'的数据！', function () {
            });
            return;
        }
        Ext.lt.ui.confirm('是否'+ actionname +'已选择数据？', null, function (is) {
            if (is) {
                var params = {};
                params.actioncode = actioncode;
                params.selDatas = datas;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "delayupdate", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(actionname +'成功！', function () {
                        editwindow.hide();
                        Ext.lt.pmkpi.query();
                    });
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(actionname +'失败！', function () {
                    });
                });
            }
        });
    }

    /**
     * 反馈-填报
     * @param obj
     */
    cmp.report = function (obj){
        var data = datatable.getSelected();
        if (data.length != 1) {
            Ext.lt.ui.alert("请选择一条数据进行填报/修改！", function () {
            });
            return;
        }
        var params = {};
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.mainguid = data[0].guid;
        params.taskguid = data[0].mainguid;
        var url = _uikey + ".page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, width, height, "整改反馈详情");
    }

    /**
     * 流程推进 送审/取消送审
     * @param obj
     * @returns {boolean}
     */
    cmp.wfAudit = function (obj) {
        var datas = datatable.getSelected();
        var actionname = obj.name;
        var actioncode = obj.code;
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert("请选择要" + actionname + "的数据！", function () {
            });
            return;
        }
        if(actioncode == "sendaudit"){
            if (!cmp.checklistdatas("feedback"," 反馈信息未填报，请填报后再送审！")) return false;
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.pagetype = _pagetype;
        params.busguid = _menuid + "_" + datas[0]["wfstatus"];
        common.doAction(obj, params);
    }

    /**
     * 校验列表数据
     * @param checktype 校验类型 senddelay feedback
     * @param tipmsg 提示词
     */
    cmp.checklistdatas = function (checktype , tipmsg){
        function checkCondition(checktype ,checkdata) {
            if(checktype == "senddelay"){
                return checkdata.extension_status == 1;
            }else if(checktype == "feedback"){
                return checkdata.wfstatus == null;
            }
        }
        var delayInfo = {};
        var datas = datatable.getSelected();
        for (var i = 0; i < datas.length; i++) {
            var data = datas[i];
            if (checkCondition(checktype,data)) {
                var colmap = datatable.getColMapper('lead_agency', data.lead_agency);
                if (!delayInfo.hasOwnProperty(data.name)) {
                    delayInfo[data.name] = [];
                }
                delayInfo[data.name].push(colmap.code + "-" + colmap.name);
            }
        }
        var hasDelay = false;
        for (var key in delayInfo) {
            if (delayInfo.hasOwnProperty(key)) {
                hasDelay = true;
                break;
            }
        }
        if (hasDelay) {
            var messages = [];
            for (var proj in delayInfo) {
                if (delayInfo.hasOwnProperty(proj)) {
                    var units = [];
                    for (var j = 0; j < delayInfo[proj].length; j++) {
                        if (delayInfo[proj][j] != null) { // 过滤空值
                            units.push(delayInfo[proj][j]);
                        }
                    }
                    messages.push(proj + "[" + units.join("、") + "]");
                }
            }
            var joinedMsg = "";
            for (var k = 0; k < messages.length; k++) {
                joinedMsg += (k > 0 ? "，" : "") + messages[k];
            }
            var finalMessage = joinedMsg + tipmsg;
            Ext.lt.ui.alert(finalMessage, function() {});
            return false;
        }else{
            return true;
        }
    }

    /**
     * 切换页签
     * @param obj
     */
    cmp.clickTabpage = function (obj) {
        _tabhidtbtn = obj.hidebtns;
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        common.changTooltoolbuttontStatus(0,obj.hidebtns);
        if (!isfirst) {
            cmp.changetablecols();
        }
        Ext.lt.pmkpi.query();
    }

    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        if (isfirst) {
            cmp.changetablecols();
        }
    });

    cmp.changetablecols = function (){
        var allcols = datatable.getAllCols(); //获取列表所有列
        for (var i = 0, len = allcols.length; i < len; i++) {
            var col = allcols[i];
            var config = eval(col.config);
            var colisvisiable = col.isvisiable;
            var colhead = col.head;
            if (col.alias != "序号" && col.colcode != "guid") {
                if(_tabcode == "senddelay"){
                    if(colisvisiable ==1 && colhead.indexOf('整改清单') !== -1 || colhead.indexOf('被评价单位') !== -1){
                        col.display = false;
                    }
                    if(colisvisiable ==1 && (col.colcode == 'plan_file' || col.colcode == 'support_file')){
                        col.display = false;
                    }
                    if(colisvisiable ==0 && (col.colcode == 'extension_reason' || col.colcode == 'extension_time')){
                        col.display = true;
                    }
                }else{
                    if (!$.isEmptyObject(config) && config.pagetype && config.pagetype == _pagetype) {
                        col.display = true;
                    } else if (!$.isEmptyObject(config) && config.pagetype){
                        col.display = false;
                    } else if (colisvisiable ==1 ){
                        col.display = true;
                    }
                }
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 关闭页面
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
    }

    /**
     * 审核情况
     */
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    /**
     * 延期申请窗口.
     * @constructor
     */
    cmp.SendWindow = function () {
        var buttons = [];
        buttons.push({
            name: 'boardsave',
            title: '提交',
            icon: 'boardsave',
            action: function () {
                Ext.lt.message.send("submit", "sendeditform");
            },
            disabled: false
        });
        buttons.push({
            name: 'del',
            title: '取消',
            icon: 'del',
            action: function () {
                editwindow.hide();
                Ext.lt.ui.loadingClose();
            },
            disabled: false
        });
        editwindow = new Ext.lt.ui.window({
            title: '延期申请',
            pop: true,
            mark: true,
            w: 0.8*width,
            h: 0.5*height,
            fitmode: 'body',
            className: 'windpblue',
            buttons: buttons
        });
        editwindow.style.display = "none";
        editwindow.draw(editform);
    }

    /**
     * 快速查询消息
     */
    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        _queryConfig = queryform.getQueryParam();
        if(_queryConfig[0].ALL_COLUMNS) {
            _querySql = "";
        } else {
            _querySql = queryform.getQuerySQL();
        }
        Ext.lt.pmkpi.query();
    });

    /**
     * 表格加载消息
     */
    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode; //显示的数据
        _defquery = uiconfig.defquery;
        var config = obj.table.config;
        _uikey = config.uikey;
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "plan_file") {
                col.cseditfn = function (i, j, rs, style) {
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, val) {
                    var colcodevalue = !data.plan_file ? 0 : data.plan_file;
                    var html = ""
                    var filetype = "problemtaskplan";
                    if (colcodevalue > 0) {
                        html = '<a title = "已上传" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:queryfilepage("'+data.guid+'","'+filetype+'")\'>已上传</a>';
                    }
                    return html;
                }
            }
            if (col["colcode"] == "support_file") {
                col.cseditfn = function (i, j, rs, style) {
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, val) {
                    var colcodevalue = !data.support_file ? 0 : data.support_file;
                    var html = ""
                    var filetype = "problemtaskfeedback";
                    if (colcodevalue > 0) {
                        html = '<a title = "已上传" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:queryfilepage("'+data.guid+'","'+filetype+'")\'>已上传</a>';
                    }
                    return html;
                }
            }
        }
    });

    /**
     * 初始化
     */
    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        cmp.SendWindow(); //初始化自定义window.
        cmp.setTableColum();
        Ext.lt.pmkpi.query();
        isfirst = false;
    });

    /**
     * 动态配置表格的列.
     * @param data --
     */
    cmp.setTableColum = function () {
        var allcols = datatable.getAllCols(); //获取列表所有列
        for (var i = 0, len = allcols.length; i < len; i++) {
            var col = allcols[i];
            var config = eval(col.config);
            var colisvisiable = col.isvisiable;
            if (colisvisiable ==1 && config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.pagetype && config.pagetype == _pagetype) {
                    col.display = true;
                } else if (config.pagetype){
                    col.display = false;
                }
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 批量导出附件
     */
    cmp.expfile = function(obj) {
        var buttonconfig = eval('(' + obj.config + ')');
        var data = datatable.getSelected();
        if(data.length < 1){
            Ext.lt.ui.alert( "请选择数据进行附件导出！",function(){
            });
            return;
        }
        var list = [];
        for (var i = 0; i < data.size(); i++) {
            var params = {};
            params.guid = data[i].guid;//数据id
            params.name = data[i].name;//名称
            params.code = data[i].pro_code;//项目编码
            var colmap = datatable.getColMapper('lead_agency',data[i].agency_code);
            params.agency = colmap.code+"-"+colmap.name;//单位
            list.push(params);
        }
        var params = {};
        params.bustype = "problemtaskfeedback" ; // 文件表类型
        params.fileexptype = "problemtaskfeedback";
        params.list = list;
        params.tokenid = Ext.lt.token.getTokenid();
        params.zipname = buttonconfig.zipname;
        Ext.lt.RCP.down("pmkpi.perfcommon.fileexp.FileExpService",'indexFileExp',params,'downframe');
    }

    return cmp;
}

function queryfilepage(billguid,filetype){
    var params = {};
    params.mainguid = billguid;
    params.filebustype = filetype;
    params.viewtype = "query";
    var url = "/pmkpi/upload/file/index.page";
    url = Ext.lt.pmkpi.genPageUrl(url, params);
    Ext.lt.ui.openModalWindow(url, width, height, "附件详情");
}
