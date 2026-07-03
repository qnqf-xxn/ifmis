if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.perfSupervision){
    Ext.lt.pmkpi.perfSupervision = {};
}

Ext.lt.pmkpi.perfSupervision.updateIndex = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var guids = config.guids,
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;
    var agencydata;

    var serviceid = service;
    cmp.save = function(){
        var params = {};

        var editformObj = editform.getEditFormValues();
        params.editformObj = editformObj;
        params.guids = guids;
        var promptMsg = '是否确定修改？';
        Ext.lt.ui.confirm(promptMsg,null,function(is){
            if(is){
                var result = Ext.lt.RCP.asyncall(serviceid , "save", params);
                if(result.error){
                    Ext.lt.ui.alert(config.error);
                } else {
                    Ext.lt.ui.alert('操作成功！',function(){
                        var allDatas = parent.datatable.getRecordSet().toArray();
                        var guidsArray= [];
                        guidsArray = guids[0].split(",");
                        for(var i=0;i<allDatas.length;i++){
                            var datas = allDatas[i];
                            if(guidsArray.indexOf(datas.guid) > -1){
                                datas.adjoption = editformObj.adjoption;
                                datas.options = editformObj.options;
                            }
                        }
                        // adjp_source = [["1","1","指标不够完整"],["2","2","指标不够细化、量化"],["3","3","指标与项目的相关性不够"],["4","4","指标与指标值不匹配"],["5","5","建议拆分指标"],["6","6","一级指标类型错误"],["7","7","二级指标类型错误"],["8","8","建议增加明确效益指标"],["9","9","建议增加明确产出指标"],["10","10","建议增加满意度指标"],["11","11","其他"]];
                        // parent.datatable.addMapperDatas("adjoption",adjp_source);
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.closeModalWindow();// 关闭
                        parent.window.Ext.lt.pmkpi.query();
                    });
                }
            }
        });
    }
    return cmp;
}

