特点：
	BaseDaoImpl使用反射和泛型使得代码得到更好的重用；
	重要的jsp页面都放置在WEB-INF下，系统封闭而安全。

相比于v1.1的改进：
	在获取BaseDaoImpl中添加了getRowCount()方法和SQL语句优化，使得分页能够真正地减轻服务器压力；
	在UserDaoImpl中新添加getUserByUsername()方法，使单例查询更加有效；
	重构部分servlet，增强了非空判断，可以杜绝大部分非正常访问；
	状态过滤器(LoginFilter)生效；
	修复了隐蔽的中文乱码问题；
	设置了错误页(error.jsp)。
	
	项目在myeclipse 2013中完成，迁移到10版本发现需要build path
	可以右键点击项目名称-->Build Path-->Add Libraries...-->MyEclipse Library-->next-->JavaEE 6.0 Generic Library-->Finish

	还有其他问题的话请联系我：zjuwmh@gmail.com
