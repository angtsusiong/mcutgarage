//拿到預覽用的 HTML 結構
var pswpElement = document.querySelectorAll('.pswp')[0];

//存放要顯示的圖片群組
var imgitems;

/**
* 用於顯示預覽介面
* @param index 圖片群組索引
*/
function viewImg(index) {
	var pswpoptions = {
		index: parseInt(index, 10), // 開始幻燈片索引。0 是第一張。必須是整数，而不是字串。
		bgOpacity: 0.7, // 背景透明度，0 到 1 的數值
		maxSpreadZoom: 3 // 縮放级别
	};

	//初始化並打開PhotoSwipe，pswpElement對應上面預覽結構，PhotoSwipeUI_Default為顯示的介面，imgitems为圖片群組，pswpoptions為選項
	var gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, imgitems, pswpoptions);
	gallery.init()
}

/**
* 用於加入圖片點擊事件處理器
* @param img 圖片
* @param index 所屬索引（在imgitems中的位置）
*/
function addImgClick(img, index) {
	img.onclick = function() {
		viewImg(index)
	}
}

/**
* 找尋所有要使用 PhotoSwipe 的圖片，取得 src、width、height 等資料，加入imgitems，並為圖片增加事件處理器
* 可以在圖片載入完成之後，呼叫此方法
*/
function initImg() {
	// 重置圖片群組
	imgitems = [];

	// 找尋 class 是 photoswipe-show 下的所有 img 元素
	var imgs = document.querySelectorAll('.photoswipe-show img');
	for (var i = 0; i < imgs.length; i++) {
		var img = imgs[i];

		var ds = img.getAttribute("src");

		// 建立 image 物件，用來取得圖片的寬高資料
		var imgtemp = new Image();

		// 判断是否存在 src
		if (ds != null && ds.length > 0) {
			imgtemp.src = ds
		} else {
			imgtemp.src = img.src
		}

		// 判断是否存在快取
		if (imgtemp.complete) {
			var imgobj = {
				"src": imgtemp.src,
				"w": imgtemp.width,
				"h": imgtemp.height,
				"msrc": "/static/img/preloader.gif"
			};
			imgitems[i] = imgobj;
			addImgClick(img, i);
		} else {
			imgtemp.index = i;
			imgtemp.img = img;
			imgtemp.onload = function() {
				var imgobj = {
					"src": this.src,
					"w": this.width,
					"h": this.height,
					"msrc": "/static/img/preloader.gif"
				};
				// 不要使用push，因為 onload 前後順序會不同
				imgitems[this.index] = imgobj

				// 增加點擊事件處理器
				addImgClick(this.img, this.index);
			}
		}
	}
}

// 初始化
initImg();
