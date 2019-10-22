import Foundation
class Solution {
    func findPairs(_ nums: [Int], _ k: Int) -> Int {
        if k < 0 {
            return 0
        }
        var count = 0
        var dic : [Int : [Int]] = [:]
        for (idx, num) in nums.enumerated() {
            print(dic)
            var temp = dic[num]
            if k == 0 && temp != nil && !temp!.contains(num){
                count += 1
                temp!.append(num)
                dic[num] = temp!
                continue
            }
            if temp == nil {
                dic[num] = [];
            }
            if k == 0 {
                continue;
            }
            let target1 = num - k
            let target2 = num + k
            var arr = dic[num]
            var arr1 = dic[target1]
            if dic[target1] != nil && !arr1!.contains(num) && !arr!.contains(target1) {
                count += 1
                arr1!.append(num);
                dic[target1] = arr1!
            }
            var arr2 = dic[target2]
            if dic[target2] != nil && !arr2!.contains(num) && !arr!.contains(target2) {
                count += 1
                arr2!.append(num);
                dic[target2] = arr2!
            }
            
        }
        return count

    }
}
var arr : [Int] = [6,3,5,7,2,3,3,8,2,4]
Solution.init().findPairs(arr, 2)










