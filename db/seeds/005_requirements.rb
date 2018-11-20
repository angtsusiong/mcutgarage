# -*- coding: utf-8 -*-
requirements = [
  { name: '作品構想摘要', datatype: 'text', desc: '', minimum: 300, maximum: 10000},
  { name: '動機與目的', datatype: 'text', desc: '', minimum: 50, maximum: 10000},
  { name: '產品與服務內容', datatype: 'text', desc: '闡明創意的創新性內容與特色、創意的可實現性及預期功能與效果之具體規劃，需敘述作品的系統架構、基本理論、設計或製作的原理與方法，時程的安排，材料與經費的估算，以及預期的困難與可能的解決對策與方法等，至少500字。', minimum: 500, maximum: 10000},
  { name: '作品貢獻性', datatype: 'text', desc: '如對社會及生活的改善等。', minimum: 50, maximum: 10000},
  { name: '創作團隊的組成與特色', datatype: 'text', desc: '團隊成員專長、隊員的分工規劃、主要經歷/得獎經歷、執行能力表現。', minimum: 50, maximum: 10000},
  { name: '構想影片', datatype: 'video', desc: '1支', minimum: 1, maximum: 1},
  { name: '構想照片', datatype: 'picture', desc: '2-5張', minimum: 2, maximum: 5},
  { name: '附件', datatype: 'text', desc: '其他欲補充之資料。', minimum: 0, maximum: 10000},
  { name: '過去創業學習經驗', datatype: 'text', desc: '闡述參加相關創業課程、講座等證明。', minimum: 50, maximum: 10000},
  { name: '創業構想', datatype: 'text', desc: '', minimum: 50, maximum: 10000},
  { name: '競爭對手與競爭策略分析', datatype: 'text', desc: '', minimum: 50, maximum: 10000},
  { name: '市場驗證', datatype: 'text', desc: '', minimum: 50, maximum: 10000},
  { name: '營運模式', datatype: 'text', desc: '', minimum: 50, maximum: 10000},
  { name: '目標市場特性與規模', datatype: 'text', desc: '', minimum: 50, maximum: 10000},
  { name: '目標消費族群', datatype: 'text', desc: '', minimum: 50, maximum: 10000},
  { name: '行銷策略', datatype: 'text', desc: '', minimum: 50, maximum: 10000},
  { name: '財務規劃', datatype: 'text', desc: '預估損益表、資產負債表等。', minimum: 50, maximum: 10000},
  { name: '效益說明', datatype: 'text', desc: '', minimum: 50, maximum: 10000},
]

requirements.each do | r |
  req = Requirement.new(
    {
      name: r[:name],
      datatype: r[:datatype],
      desc: r[:desc],
      minimum: r[:minimum],
      maximum: r[:maximum],
    }
  )
  req.save
end

puts "seeds 005_requirement: Create Requirements"
