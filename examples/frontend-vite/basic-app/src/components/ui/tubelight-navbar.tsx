'use client'

import { useState } from 'react'
import { motion } from 'framer-motion'
import type { LucideIcon } from 'lucide-react'

import { cn } from '@/lib/utils'

interface NavItem {
  name: string
  url: string
  icon: LucideIcon
}

interface NavBarProps {
  items: NavItem[]
  className?: string
}

const NavBar = ({ items, className }: NavBarProps) => {
  const [activeTab, setActiveTab] = useState(items[0]?.name ?? '')

  return (
    <nav
      aria-label="Primary navigation"
      className={cn(
        'fixed bottom-4 left-1/2 z-40 -translate-x-1/2 sm:top-4 sm:bottom-auto',
        className,
      )}
    >
      <div className="flex items-center gap-2 rounded-full border border-border/70 bg-background/75 px-1 py-1 shadow-[0_18px_48px_-24px_rgba(0,0,0,0.5)] backdrop-blur-xl">
        {items.map((item) => {
          const Icon = item.icon
          const isActive = activeTab === item.name

          return (
            <a
              key={item.name}
              href={item.url}
              onClick={() => setActiveTab(item.name)}
              className={cn(
                'relative rounded-full px-4 py-2 text-sm font-semibold text-foreground/72 transition-colors duration-300 hover:text-primary sm:px-5',
                isActive && 'text-primary',
              )}
            >
              <span className="hidden md:inline">{item.name}</span>
              <span className="md:hidden" aria-label={item.name}>
                <Icon size={18} strokeWidth={1.8} />
              </span>
              {isActive ? (
                <motion.span
                  layoutId="tubelight-navbar-active-tab"
                  className="absolute inset-0 -z-10 rounded-full bg-primary/10"
                  initial={false}
                  transition={{ type: 'spring', stiffness: 300, damping: 30 }}
                >
                  <span className="absolute -top-1.5 left-1/2 h-1 w-8 -translate-x-1/2 rounded-full bg-primary">
                    <span className="absolute -left-3 -top-2 h-6 w-14 rounded-full bg-primary/20 blur-md" />
                    <span className="absolute -top-1 h-5 w-8 rounded-full bg-primary/20 blur-sm" />
                  </span>
                </motion.span>
              ) : null}
            </a>
          )
        })}
      </div>
    </nav>
  )
}

export { NavBar, type NavBarProps, type NavItem }
