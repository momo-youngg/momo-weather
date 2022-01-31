//
//  ChartView.swift
//  MomoWeather
//
//  Created by momo on 2022/02/01.
//

import UIKit

struct GraphInfo {
    
    struct GraphValueInfo {
        let description: String
        let dimension: String
        let outerColor: UIColor
        let innerColor: UIColor
        var innerRadius: Double // = 8
        var outerRadius: Double // = 12
        let values: [Double]
    }
    
    let graphKeyInfo: [String]
    let graphValueInfo: [GraphValueInfo]
    
    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 110.0 / 100.0
    
    /// gap between each point
    let lineGap: CGFloat = 60.0
    
    let space: CGFloat = 40.0
    
    let fontSize: CGFloat = 11.0
    
    let lineAndLabelColor: UIColor = UIColor.white
    
    let lineWidth: Double = 0.5
}


class GraphView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    /// Contains mainLayer and label for each data entry
    private let scrollView: UIScrollView = UIScrollView()
    
    /// Contains dataLayer and gradientLayer
    private let mainLayer: CALayer = CALayer()
    
    /// Contains the main line which represents the data
    private let dataLayer: CALayer = CALayer()
    
    /// Contains horizontal lines
    private let gridLayer: CALayer = CALayer()
    
    var graphInfo: GraphInfo? = nil {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        scrollView.layer.addSublayer(mainLayer)
        self.layer.addSublayer(gridLayer)
        self.addSubview(scrollView)
        
        self.backgroundColor = .clear
    }
    
    //main
    override func layoutSubviews() {
        guard let graphInfo = graphInfo else {
            return
        }
        scrollView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: self.frame.size.width,
                                  height: self.frame.size.height)
        // once
        scrollView.contentSize = CGSize(width: CGFloat(graphInfo.graphKeyInfo.count) * graphInfo.lineGap,
                                        height: self.frame.size.height)
        mainLayer.frame = CGRect(x: 0,
                                 y: 0,
                                 width: CGFloat(graphInfo.graphKeyInfo.count) * graphInfo.lineGap,
                                 height: self.frame.size.height)
        dataLayer.frame = CGRect(x: 0,
                                 y: graphInfo.space,
                                 width: mainLayer.frame.width,
                                 height: mainLayer.frame.height - 2 * graphInfo.space)
        
        gridLayer.frame = CGRect(x: 0,
                                 y: graphInfo.space,
                                 width: self.frame.width,
                                 height: mainLayer.frame.height - 2 * graphInfo.space)
        clean()
        
        // every
        let allValues = graphInfo.graphValueInfo.flatMap{ valueInfo in valueInfo.values }
        graphInfo.graphValueInfo.forEach { valueInfo in
            let points = convertValueToPoint(allValues: allValues, targetValues: valueInfo.values)
            drawDots(points: points,
                     innerColor: valueInfo.innerColor,
                     outerColor: valueInfo.outerColor,
                     innerRadius: valueInfo.innerRadius,
                     outerRadius: valueInfo.outerRadius)
            drawHorizontalLines(allValues: allValues)
            drawChart(points: points, color: valueInfo.outerColor.cgColor)
            drawLabels()
        }
    }
    
    private func convertValueToPoint(allValues: [Double], targetValues: [Double]) -> [CGPoint] {
        guard let graphInfo = graphInfo else {
            return []
        }
        if let max = allValues.max(), let min = allValues.min() {
            let minMaxRange: CGFloat = CGFloat(max - min) * graphInfo.topHorizontalLine
            return targetValues.indices.map { index in
                let height = dataLayer.frame.height * (1 - ((CGFloat(targetValues[index]) - CGFloat(min)) / minMaxRange))
                return CGPoint(x: CGFloat(index) * graphInfo.lineGap + graphInfo.space, y: height)
            }
        }
        return []
    }
    
    private func drawChart(points: [CGPoint], color: CGColor) {
        if !points.isEmpty, let path = createPath(points: points) {
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = color
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }
    
    private func createPath(points: [CGPoint]) -> UIBezierPath? {
        guard !points.isEmpty else {
            return nil
        }
        let path = UIBezierPath()
        path.move(to: points[0])
        points[1..<points.count].forEach { point in
            path.addLine(to: point)
        }
        return path
    }
    
    private func drawLabels() {
        guard let graphInfo = graphInfo else {
            return
        }
        let keys = graphInfo.graphKeyInfo
        if keys.count > 0 {
            keys.indices.forEach { index in
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: graphInfo.lineGap * CGFloat(index) - graphInfo.lineGap/2 + graphInfo.space, y: mainLayer.frame.size.height - graphInfo.space/2 - 8, width: graphInfo.lineGap, height: 16)
                textLayer.foregroundColor = graphInfo.lineAndLabelColor.cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.fontSize = graphInfo.fontSize
                textLayer.string = keys[index]
                mainLayer.addSublayer(textLayer)
            }
        }
    }
    
    private func drawHorizontalLines(allValues: [Double]) {
        guard let graphInfo = graphInfo else {
            return
        }
        let gridValues: [CGFloat] = {
            if allValues.count < 4 && allValues.count > 0 {
                return [0, 1]
            } else {
                return [0, 0.25, 0.5, 0.75, 1]
            }
        }()
        for value in gridValues {
            let height = value * gridLayer.frame.size.height
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: gridLayer.frame.size.width, y: height))
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.fillColor = UIColor.clear.cgColor
            lineLayer.strokeColor = graphInfo.lineAndLabelColor.cgColor
            lineLayer.lineWidth = graphInfo.lineWidth
            // 중간에 있는 선들은 dashed
            if (value > 0.0 && value < 1.0) {
                lineLayer.lineDashPattern = [4, 4]
            }
            gridLayer.addSublayer(lineLayer)
            
            var minMaxGap:CGFloat = 0
            var lineValue:Int = 0
            if let max = allValues.max(), let min = allValues.min() {
                minMaxGap = CGFloat(max - min) * graphInfo.topHorizontalLine
                lineValue = Int((1-value) * minMaxGap) + Int(min)
            }
            
            let textLayer = CATextLayer()
            textLayer.frame = CGRect(x: 4, y: height, width: 50, height: 16)
            textLayer.foregroundColor = graphInfo.lineAndLabelColor.cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
            textLayer.fontSize = graphInfo.fontSize
            textLayer.string = "\(lineValue)"
            
            gridLayer.addSublayer(textLayer)
        }
    }
    
    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
        gridLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }

    private func drawDots(points: [CGPoint], innerColor: UIColor, outerColor: UIColor ,innerRadius: Double, outerRadius: Double) {
        guard let graphInfo = graphInfo else {
            return
        }
        var dotLayers: [CALayer] = []
            for point in points {
                let xValue = point.x - outerRadius/2
                let yValue = (point.y + graphInfo.lineGap) - (outerRadius * 2)
                let dotLayer = DotCALayer(innerRadius: innerRadius, dotInnerColor: innerColor)
                dotLayer.backgroundColor = outerColor.cgColor
                dotLayer.cornerRadius = outerRadius / 2
                dotLayer.frame = CGRect(x: xValue, y: yValue, width: outerRadius, height: outerRadius)
                dotLayers.append(dotLayer)
                mainLayer.addSublayer(dotLayer)
            }
    }
    
    class DotCALayer: CALayer {

        var innerRadius: CGFloat
        var dotInnerColor: UIColor

        init(innerRadius: CGFloat, dotInnerColor: UIColor) {
            self.innerRadius = innerRadius
            self.dotInnerColor = dotInnerColor
            super.init()
        }

        required init?(coder aDecoder: NSCoder) {
            self.innerRadius = 8.0
            self.dotInnerColor = .black
            super.init(coder: aDecoder)
        }

        override func layoutSublayers() {
            super.layoutSublayers()
            let inset = self.bounds.size.width - innerRadius
            let innerDotLayer = CALayer()
            innerDotLayer.frame = self.bounds.insetBy(dx: inset/2, dy: inset/2)
            innerDotLayer.backgroundColor = dotInnerColor.cgColor
            innerDotLayer.cornerRadius = innerRadius / 2
            self.addSublayer(innerDotLayer)
        }
    }

}
