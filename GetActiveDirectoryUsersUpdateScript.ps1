<script language="javascript" type="text/javascript" src="https://c986.sharepoint.com/SiteAssets/jquery-1.8.3.min.js"></script>  
<script language="ecmascript" type="text/ecmascript">  
var collListItem;  
$(document).ready(function () {  
   var empIDField = $("input[title='Employee Id']");  
   empIDField.change(function () {  
   getSetListItem()  
  
function getSetListItem() {  
   var empID = $("input[title='Employee Id']").val();  
   var clientContext = new SP.ClientContext.get_current();  
   var oList = clientContext.get_web().get_lists().getByTitle('Parent');  
   var camlQuery = new SP.CamlQuery();  
   camlQuery.set_viewXml('  
    <View>  
        <Query>  
            <Where>  
                <Eq>  
                    <FieldRef Name=\'EmployeeId\' />  
                    <Value Type=\'Text\'>' + empID + '</Value>  
                </Eq>  
            </Where>  
        </Query>  
        <RowLimit>10</RowLimit>  
    </View>');  
   collListItem = oList.getItems(camlQuery);  
   clientContext.load(collListItem);  
   clientContext.executeQueryAsync(Function.createDelegate(this, OnLoadSuccess),  
   Function.createDelegate(this, OnLoadFailed));  
}  
  
function OnLoadSuccess(sender, args) {  
   var listItemEnumerator = collListItem.getEnumerator();  
   while (listItemEnumerator.moveNext()) {  
      var oListItem = listItemEnumerator.get_current();  
      $("input[title='First Name']").val(oListItem.get_item("FirstName"))  
      $("input[title='Last Name']").val(oListItem.get_item("LastName"))  
   }  
}  
  
function OnLoadFailed(sender, args) {  
   alert('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());  
   }  
});  
});  
  
</script>  