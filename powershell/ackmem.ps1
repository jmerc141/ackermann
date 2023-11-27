function Get-Ackermann ([int64]$m, [bigint]$n)
{
    if ($map.ContainsKey("$m" + "$n"))
    {
        # Do nothing
    }
    else
    {
        if ($m -eq 0)
        {
            $map.Add("$m" + "$n", $n+1)
        }
        elseif ($n -eq 0)
        {
            $map.Add("$m" + "$n", (Get-Ackermann ($m-1) 1))
        }
        else
        {
			$tmp = (Get-Ackermann ($m - 1) (Get-Ackermann $m ($n - 1)))
            $map.Add("$m" + "$n", $tmp)
        }
    }
	
    return $map["$m" + "$n"]
}


$map = @{}

Get-Ackermann $args[0] $args[1]
