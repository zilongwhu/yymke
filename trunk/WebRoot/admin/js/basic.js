function  getInputValue(id)
{
  var value = $F(id).replace(/^\s+/,'');
  	value = value.replace(/\s+$/,'');
  return value;
}