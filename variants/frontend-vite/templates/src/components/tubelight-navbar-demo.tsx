import { Briefcase, FileText, Home, User } from 'lucide-react'

import { NavBar } from '@/components/ui/tubelight-navbar'

const navItems = [
  { name: 'Home', url: '#home', icon: Home },
  { name: 'About', url: '#about', icon: User },
  { name: 'Projects', url: '#projects', icon: Briefcase },
  { name: 'Resume', url: '#resume', icon: FileText },
]

const TubelightNavbarDemo = () => {
  return <NavBar items={navItems} />
}

export { TubelightNavbarDemo }
