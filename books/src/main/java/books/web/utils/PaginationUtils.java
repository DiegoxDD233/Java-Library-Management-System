package books.web.utils;
/**
 * 分页工具类
 * @author NINGMEI
 *
 */
public class PaginationUtils {
	
	//public static int page_num = 1;
	//public static int page_size = 5;
	public static String baseUrl = "books";
	
		
	/**
	 * 分页控件
	 * @param totalNum
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public static String getPagation(long totalNum,int currentPage,int pageSize,String path){
		long totalPage=totalNum%pageSize==0?totalNum/pageSize:totalNum/pageSize+1;//7,totalPage表示一共有多少页
		StringBuffer pageCode=new StringBuffer();
		pageCode.append("<div class=\"col-md-7 col-md-push-3\">");
		pageCode.append("<nav ><ul class=\"pagination pagination-md\" id=\"pageSorter\">");
		if(currentPage==1){
			pageCode.append("<li class='disabled'><a>Home</a></li>");
			pageCode.append("<li class='disabled'><a href='#'>Previous</a></li>");
			
		}else{
			pageCode.append("<li><a href='/" + baseUrl + "/"+ path +"&pageNum=1'>Home</a></li>");
			pageCode.append("<li><a href='/" + baseUrl + "/"+ path +"&pageNum="+(currentPage-1)+"'>Previous</a></li>");
		}
		
		for(int i=currentPage-5;i<=currentPage+5;i++){
			if(i<1||i>totalPage){
				continue;
			}
			if(i==currentPage){
				pageCode.append("<li class='active'><a href='#'>"+i+"</a></li>");
			}else{
				pageCode.append("<li><a href='/" + baseUrl + "/"+path+"&pageNum="+i+"'>"+i+"</a></li>");
			}
		}
		
		if(currentPage==totalPage){
			pageCode.append("<li class='disabled'><a href='#'>Next</a></li>");
			pageCode.append("<li class='disabled'><a>Last</a></li>");
		}else{
			pageCode.append("<li><a href='/" + baseUrl + "/"+ path +"&pageNum="+(currentPage+1)+"'>Next</a></li>");
			pageCode.append("<li><a href='/" + baseUrl + "/"+ path +"&pageNum="+totalPage+"'>Last</a></li>");
		}
		pageCode.append("</ul></nav></div>");
		return pageCode.toString();
	}
}
