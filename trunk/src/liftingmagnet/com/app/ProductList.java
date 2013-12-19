package liftingmagnet.com.app;

import java.util.Vector;

import javax.servlet.ServletContext;

import liftingmagnet.com.db.dao.Catalog;
import liftingmagnet.com.util.StringHelper;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class ProductList {
	
	public void generateList(ServletContext application)
	{
		Vector<Integer> orders = new Vector<Integer>();
		Vector<Catalog> types = Catalog.loadChildsFromDB(-1);
		Vector<Integer> folders = new Vector<Integer>();
		StringBuffer str = new StringBuffer();
		int size = types.size();
		for (int i=0;i<size;i++)
		{
			str.append(buildList(buildJSONNode(types.get(i),orders),new Vector<Boolean>(),i==size-1,folders));
		}
		StringBuffer sb = new StringBuffer("<script type='text/javascript'>window.onload=function(){");
		size = folders.size();
		for (int i=0;i<size;i++)
		{
			sb.append("Event.observe($('pl_img_"+folders.get(i)+"'),'click',toggleChildByImg);");
		}
		sb.append("fix_ie_overflow_bug();}</script>");
		str.append(sb);
		
		application.setAttribute("product_list", str.toString());
		application.setAttribute("product_orders", orders);
	}
	
	private JSONObject buildJSONNode(Catalog catalog,Vector<Integer> orders)
	{
		JSONObject obj = new JSONObject();
		try {
			String name = catalog.getName();
			int len = name.length();
			obj.put("id", catalog.getId());
			obj.put("name", len>30?name.substring(0, 27)+"...":name);
			obj.put("title", name);
			obj.put("opened", catalog.isOpened());
			obj.put("type", catalog.getType());
			JSONArray arr = new JSONArray();
			if (catalog.getType()==0)
			{
				Vector<Catalog> childs = Catalog.loadChildsFromDB(catalog.getId());
				int size = childs.size();
				for (int i=0;i<size;i++)
				{
					arr.put(buildJSONNode(childs.get(i),orders));
				}
			}
			else if(catalog.getType()==2)
			{
				orders.add(catalog.getId());
			}
			obj.put("child", arr);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return obj;
	}
	
	private String buildList(JSONObject root,Vector<Boolean> flags,boolean isLast,Vector<Integer> folders)
	{
		StringBuffer sb = new StringBuffer("<div>");
		try {
			int size = flags.size();
			for (int i=0;i<size;i++)
			{
				if (flags.get(i))
				{
					sb.append("<img src='images/tree/tree_line.gif' />");
				}
				else
				{
					sb.append("<img src='images/tree/tree_empty.gif' />");
				}
			}
			if (root.getInt("type")==0)
			{
				JSONArray arr = (JSONArray)root.get("child");
				if (arr.length()>0)
				{
					if (root.getBoolean("opened"))
					{
						if (isLast)
						{
							sb.append("<img id='pl_img_"+root.getInt("id")+"' src='images/tree/tree_minusbottom.gif' title='fold' style='cursor:pointer;'/>");
						}
						else
						{
							sb.append("<img id='pl_img_"+root.getInt("id")+"' src='images/tree/tree_minusmiddle.gif' title='fold' style='cursor:pointer;'/>");
						}
						sb.append("<a id='pl_a_"+root.getInt("id")+"' target='_self' title=\""+StringHelper.transform(root.getString("title"), '"', "'")+"\" href=\"javascript:toggleChildByLink('pl_a_"+root.getInt("id")+"');\" class='folder_open'>"+root.getString("name")+"</a>");
						sb.append("<div>");
					}
					else
					{
						if (isLast)
						{
							sb.append("<img id='pl_img_"+root.getInt("id")+"' src='images/tree/tree_plusbottom.gif' title='unfold' style='cursor:pointer;'/>");
						}
						else
						{
							sb.append("<img id='pl_img_"+root.getInt("id")+"' src='images/tree/tree_plusmiddle.gif' title='unfold' style='cursor:pointer;'/>");
						}
						sb.append("<a id='pl_a_"+root.getInt("id")+"' target='_self' title=\""+StringHelper.transform(root.getString("title"), '"', "'")+"\" href=\"javascript:toggleChildByLink('pl_a_"+root.getInt("id")+"');\" class='folder_close'>"+root.getString("name")+"</a>");
						sb.append("<div style='display:none;'>");
					}
					folders.add(root.getInt("id"));
					flags.add(!isLast);
					for (int i=0;i<arr.length();i++)
					{
						sb.append(buildList((JSONObject)arr.get(i),flags,i==arr.length()-1,folders));
					}
					flags.remove(flags.size()-1);
					sb.append("</div>");
				}
				else
				{
					if (isLast)
					{
						sb.append("<img src='images/tree/tree_linebottom.gif' title='fold' style='cursor:pointer;'/>");
					}
					else
					{
						sb.append("<img src='images/tree/tree_minusmiddle.gif' title='fold' style='cursor:pointer;'/>");
					}
					sb.append("<a target='_self' title=\""+StringHelper.transform(root.getString("title"), '"', "'")+"\" href='javascript:;' class='folder_close'>"+root.getString("name")+"</a>");
				}
			}
			else
			{
				if (isLast)
				{
					sb.append("<img src='images/tree/tree_linebottom.gif' />");
				}
				else
				{
					sb.append("<img src='images/tree/tree_linemiddle.gif' />");
				}
				if (root.getInt("type")==1)
				{
					sb.append("<a href='viewInfo.jsp?id="+root.getInt("id")+"' target='_blank' title=\""+StringHelper.transform(root.getString("title"), '"', "'")+"\" class='info'>"+root.getString("name")+"</a>");
				}
				else
				{
					sb.append("<a href='viewProduct.jsp?id="+root.getInt("id")+"' target='_blank' title=\""+StringHelper.transform(root.getString("title"), '"', "'")+"\" class='product'>"+root.getString("name")+"</a>");
				}
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		sb.append("</div>");
		return sb.toString();
	}
}
