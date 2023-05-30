function Get-Ackermann ([int64]$m, [bigint]$n)
{
    if ($m -eq 0)
    {
        return $n + 1
    }
 
    if ($n -eq 0)
    {
        return Get-Ackermann ($m - 1) 1
    }
 
    return (Get-Ackermann ($m - 1) (Get-Ackermann $m ($n - 1)))
}

Get-Ackermann $args[0] $args[1]
