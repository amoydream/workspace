package com.lauvan.system.vo;

import java.io.Serializable;
import java.util.List;

/**
 * ClassName: TreeVo
 * @Description: 系统菜单树
 * @author 钮炜炜
 * @date 2015年11月26日 下午4:01:32
 */
public class TreeVo implements Serializable {
	private static final long	serialVersionUID	= 3311551685982779776L;
	private String				text;
	private String				href;
	private String				name;
	private List<TreeVo>		nodes;

	public TreeVo() {
	}

	public TreeVo(String text, String href) {
		this.text = text;
		this.href = href;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<TreeVo> getNodes() {
		return nodes;
	}

	public void setNodes(List<TreeVo> nodes) {
		this.nodes = nodes;
	}
}
