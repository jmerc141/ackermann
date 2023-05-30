function Get-Ackermann ([int64]$m, [int64]$n)
{
    [System.Collections.ArrayList]$arr = @($m)
    $res=$n
    $i = 0

    while($arr.count -gt 0)
    {

        if($arr[$i] -gt 0 -And $res -gt 0)
        {
            $arr+=$arr[$i]
            $arr[$i]--
            $res--
            $i++
        } elseif ($arr[$i] -gt 0 -And $res -eq 0) {
            $arr[$i]--
            $res=1
        } elseif ($arr[$i] -eq 0) {
            $res++
            $arr.RemoveAt(($arr.count-1))
            $i--
        }        
    }

    Write-Host Result: $res
}

Get-Ackermann $args[0] $args[1]
