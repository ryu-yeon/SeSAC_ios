//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/20.
//

import UIKit

class SearchTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 165
    }
    
    var movieArray: [String] = ["범죄도시2", "마녀", "토르"]
    var dateArray: [String] = ["2022.01.01", "2022.02.02", "2022.04.04"]
    var summaryArray: [String] = ["가리봉동 소탕작전 후 4년 뒤, 금천서 강력반은 베트남으로 도주한 용의자를 인도받아 오라는 미션을 받는다. 괴물형사 ‘마석도’(마동석)와 ‘전일만’(최귀화) 반장은 현지 용의자에게서 수상함을 느끼고, 그의 뒤에 무자비한 악행을 벌이는 ‘강해상’(손석구)이 있음을 알게 된다. ‘마석도’와 금천서 강력반은 한국과 베트남을 오가며 역대급 범죄를 저지르는 ‘강해상’을 본격적으로 쫓기 시작하는데... 나쁜 놈들 잡는 데 국경 없다! 통쾌하고 화끈한 범죄 소탕 작전이 다시 펼쳐진다!", "’자윤’이 사라진 뒤, 정체불명의 집단의 무차별 습격으로 마녀 프로젝트가 진행되고 있는 ‘아크’가 초토화된다. 그곳에서 홀로 살아남은 ‘소녀’는 생애 처음 세상 밖으로 발을 내딛고 우연히 만난 ‘경희’의 도움으로 농장에서 지내며 따뜻한 일상에 적응해간다. 한편, ‘소녀’가 망실되자 행방을 쫓는 책임자 ‘장’과 마녀 프로젝트의 창시자 ‘백총괄’의 지령을 받고 제거에 나선 본사 요원 ‘조현’, ‘경희’의 농장 소유권을 노리는 조직의 보스 ‘용두’와 상해에서 온 의문의 4인방까지 각기 다른 목적을 지닌 세력이 하나 둘 모여들기 시작하면서 ‘소녀’ 안에 숨겨진 본성이 깨어나는데… 모든 것의 시작, 더욱 거대하고 강력해진 마녀가 온다.", "슈퍼 히어로 시절이여, 안녕! 이너피스를 위해 자아 찾기 여정을 떠난 천둥의 신 ‘토르’ 그러나, 우주의 모든 신들을 몰살하려는 신 도살자 ‘고르’의 등장으로 ‘토르’의 안식년 계획은 산산조각 나버린다. ‘토르’는 새로운 위협에 맞서기 위해, ‘킹 발키리’, ‘코르그’, 그리고 전 여자친구 ‘제인’과 재회하게 되는데, 그녀가 묠니르를 휘두르는 ‘마이티 토르’가 되어 나타나 모두를 놀라게 한다. 이제, 팀 토르는 ‘고르’의 복수에 얽힌 미스터리를 밝히고 더 큰 전쟁을 막기 위한 전 우주적 스케일의 모험을 시작하는데... 우주 최고의 ‘갓’ 매치가 시작된다!"]
                                  
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        cell.movieImageView.image = UIImage(named: "movie\(indexPath.row)")
        cell.titleLabel.text = movieArray[indexPath.row]
        cell.dateLabel.text = dateArray[indexPath.row]
        cell.summaryLabel.text = summaryArray[indexPath.row]
        
        return cell
    }
}
