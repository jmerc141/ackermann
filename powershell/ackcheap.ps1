function StAckermann ([int64]$m, [bigint]$n)
{

    if ($m -eq 0)
    {
        return $n + 1
    }
    
    if ($m -eq 1)
    {
        return $n + 2
    }
 
    if ($m -eq 2)
    {
       return [bigint](2 * $n) + 3
    }
 
    if ($m -eq 3)
    {
       return [bigint][bigint]::Pow(2,($n+3)) - 3
    }

    if ($m -eq 4)
    {
       return [bigint][bigint]::Pow(2,[bigint][bigint]::Pow(2,[bigint][bigint]::Pow(2,[bigint][bigint]::Pow(2,$n)))) - 3
    }

    if ($m -eq 5)
    {
       if ($n -eq 0)
       {
        return [bigint]::Pow(2,[bigint]::Pow(2,[bigint]::Pow(2,[bigint]::Pow(2,1)))) - 3
       }
       if ($n -eq 1)
       {
        return [bigint][bigint]::Pow(2,[bigint][bigint]::Pow(2,[bigint][bigint]::Pow(2,[bigint][bigint]::Pow(2,65536)))) - 3
       }
    }
}
$start = get-date
stAckermann $args[0] $args[1]
$end = get-date
Write-Host "$start, $end"