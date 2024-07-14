abbrev(ns::Nanosecond)  = "$(ns.value)ns"
abbrev(us::Microsecond) = "$(us.value)us"
abbrev(ms::Millisecond) = "$(ms.value)ms"
abbrev(s::Second)       = "$(s.value)s"
abbrev(m::Minute)       = "$(m.value)m"
abbrev(h::Hour)         = "$(h.value)h"
abbrev(d::Day)          = "$(d.value)d"
abbrev(w::Week)         = "$(w.value)w"
abbrev(M::Month)        = "$(M.value)M"
abbrev(Q::Quarter)      = "$(Q.value)Q"
abbrev(Y::Year)         = "$(Y.value)Y"
function abbrev(canon::Dates.CompoundPeriod; minimum=Minute)
    @chain canon.periods begin
        filter(p -> typeof(p) >= minimum, _)
        map(abbrev, _)
        join(" ")
    end
end

"""    abbrev(p::Period)

Return an abbreviated string representation of the given period.

# Example

```julia
abbrev(Hour(4)) # "4h"
abbrev(Day(1))  # "1d"
```
"""
abbrev(p::Period)

"""
This is a wrapper around `OnlineTechnicalIndicators.ismultiinput` that takes
any instance of a TechnicalIndicator and digs out its unparametrized type before running
the original ismultiinput method.
"""
function ismultiinput(i::TechnicalIndicator)
    t = typeof(i)
    OnlineTechnicalIndicators.ismultiinput(t.name.wrapper)
end

"""
This is a wrapper around `OnlineTechnicalIndicators.ismultioutput` that takes
any instance of a TechnicalIndicator and digs out its unparametrized type before running
the original ismultioutput method.
"""
function ismultioutput(i::TechnicalIndicator)
    t = typeof(i)
    OnlineTechnicalIndicators.ismultioutput(t.name.wrapper)
end
