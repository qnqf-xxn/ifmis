if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.editaudiview)
    Ext.lt.pmkpi.editaudiview = {};

Ext.lt.pmkpi.editaudiview = function(config, service){
	
	
    var cmp = {};
    Ext.lt.pmkpi.editaudiview.tokenid = Ext.lt.token.getTokenid();
    Ext.lt.pmkpi.editaudiview.bobeanid = config.bobeanid;
    var serviceid = service;
    if(config.EditAudi!=null && config.EditAudi!=""){
    	Ext.lt.pmkpi.editaudiview.EditAudi = config.EditAudi;
	}
	serviceid = config.serverid;
	var a=config.EditAudi;
    
    $(function(){
    	//editform.synchEditformByObj(config.EditAudi);
    	editform.synchEditformByObj(config.editAudi);
    }); 
    
    //视图校验
	cmp.checksql =function (){
		var params = editform.getEditFormValues();
		Ext.lt.RCP.call(serviceid , "checkSql", params,function(rs){
			if(rs.error){
				Ext.lt.ui.alert(rs.error);
			}else{
				Ext.lt.ui.alert(("视图校验成功！"),{}, function(ret) {	
					
				});
				
			}
		});
	}
	
	//视图保存
	cmp.save =function (){
		if (!editform.check()) return;
		var params =editform.getEditFormValues();
		params.guid=config.editAudi.guid;
		var code=params.code;
		//校验视图名称是否为空
		
			var fdStart = code.indexOf("perf_audit_v_");
			if(!fdStart == 0){
				Ext.lt.ui.alert(("视图名称以perf_audit_v_开头！"),{}, function(ret) {	
					
				});
				return;
			}
		
		
		
		
		Ext.lt.RCP.call(serviceid , "save", params,function(rs){
			if(rs.error){
				Ext.lt.ui.alert(rs.error);
			}else{
				Ext.lt.ui.alert(("视图保存成功！"),{}, function(ret) {
					parent.Ext.lt.ui.modalWindow.close();
					 parent.location.reload(); 
					//parent.cmp.tablequery();// 刷新
					
				});
				
			}
		});
	}
	
	
    return cmp;
	}

