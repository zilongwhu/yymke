package liftingmagnet.com.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.usermanage.Authority;
import liftingmagnet.com.usermanage.User;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadImage extends HttpServlet {
	private static final long serialVersionUID = 524183972018810558L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User user = (User) req.getSession().getAttribute("user");
		Authority limits = user.getLimits();

		if (limits.canAddProduct() || limits.canModifyProduct()) {
			final long MAX_SIZE = 1024 * 1024;// �����ϴ��ļ����Ϊ 1M
			final String[] allowedExt = new String[] { "jpg", "jpeg", "gif", "bmp" };// �����ϴ����ļ���ʽ���б�

			resp.setContentType("text/html");
			resp.setCharacterEncoding("UTF-8");// �����ַ�����ΪUTF-8, ����֧�ֺ�����ʾ

			// ʵ����һ��Ӳ���ļ�����,���������ϴ����ServletFileUpload
			DiskFileItemFactory dfif = new DiskFileItemFactory();
			dfif.setSizeThreshold(4096);// �����ϴ��ļ�ʱ������ʱ����ļ����ڴ��С,������4K.���ڵĲ��ֽ���ʱ����Ӳ��
			dfif.setRepository(new File(req.getSession().getServletContext().getRealPath("/tmp")));// ���ô����ʱ�ļ���Ŀ¼,web��Ŀ¼�µ�ImagesUploadTempĿ¼

			ServletFileUpload sfu = new ServletFileUpload(dfif);// �����Ϲ���ʵ�����ϴ����
			sfu.setSizeMax(MAX_SIZE);// ��������ϴ��ߴ�

			PrintWriter out = resp.getWriter();
			// ��request�õ� ���� �ϴ�����б�
			List fileList = null;
			try {
				fileList = sfu.parseRequest(req);
			} catch (FileUploadException e) {// �����ļ��ߴ�����쳣
				if (e instanceof SizeLimitExceededException) {
					out.println("�ļ��ߴ糬���涨��С:" + MAX_SIZE + "�ֽ�<p />");
					out.println("<a href=\"getProductImg.jsp\">����</a>");
					return;
				}
				e.printStackTrace();
			}
			if (fileList == null || fileList.size() == 0)// û���ļ��ϴ�
			{
				out.println("��ѡ���ϴ��ļ�<p />");
				out.println("<a href=\"getProductImg.jsp\">����</a>");
				return;
			}

			Iterator fileItr = fileList.iterator();// �õ������ϴ����ļ�

			while (fileItr.hasNext())// ѭ�����������ļ�
			{
				FileItem fileItem = null;
				String path = null;
				long size = 0;

				fileItem = (FileItem) fileItr.next();// �õ���ǰ�ļ�
				if (fileItem == null || fileItem.isFormField()) // ���Լ�form�ֶζ������ϴ�����ļ���(<input
				// type="text" />��)
				{
					continue;
				}

				if (!"img".equals(fileItem.getFieldName())) {
					continue;
				}

				path = fileItem.getName(); // �õ��ļ�������·��
				size = fileItem.getSize(); // �õ��ļ��Ĵ�С
				if ("".equals(path) || size == 0) {
					out.println("��ѡ���ϴ��ļ�<p />");
					out.println("<a href=\"getProductImg.jsp\">����</a>");
					return;
				}

				String t_name = path.substring(path.lastIndexOf("\\") + 1); // �õ�ȥ��·�����ļ���
				String t_ext = t_name.substring(t_name.lastIndexOf(".") + 1)
						.toLowerCase(); // �õ��ļ�����չ��(����չ��ʱ���õ�ȫ��)

				// �ܾ����ܹ涨�ļ���ʽ֮����ļ�����
				int allowFlag = 0;
				int allowedExtCount = allowedExt.length;
				for (; allowFlag < allowedExtCount; allowFlag++) {
					if (allowedExt[allowFlag].equals(t_ext))
						break;
				}
				if (allowFlag == allowedExtCount) {
					out.println("���ϴ��������͵��ļ�<p />");
					for (allowFlag = 0; allowFlag < allowedExtCount; allowFlag++)
					{
						out.println("*." + allowedExt[allowFlag] + "&nbsp;&nbsp;&nbsp;");
					}
					out.println("<a href=\"getProductImg.jsp\">����</a>");
					return;
				}

				long now = System.currentTimeMillis();// ����ϵͳʱ�������ϴ��󱣴���ļ���
				String prefix = String.valueOf(now);// ����������ļ�����·��,������web��Ŀ¼�µ�ImagesUploadedĿ¼��
				String u_name = req.getSession().getServletContext().getRealPath("/product_images") +
								"/" + prefix + "." + t_ext;
				try {
					fileItem.write(new File(u_name));
					out.println("<script type='text/javascript'>opener.set_path('"
									+ "/product_images/" + prefix + "." + t_ext + "');window.close();</script>");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
