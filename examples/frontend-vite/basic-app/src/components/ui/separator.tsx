import type { ComponentProps } from 'react'

import { cn } from '@/lib/utils'

interface ISeparatorProps extends ComponentProps<'div'> {
  orientation?: 'horizontal' | 'vertical'
  decorative?: boolean
}

const Separator = ({
  className,
  orientation = 'horizontal',
  decorative = true,
  ...props
}: ISeparatorProps) => {
  return (
    <div
      data-slot="separator"
      role={decorative ? 'none' : 'separator'}
      aria-orientation={decorative ? undefined : orientation}
      data-orientation={orientation}
      className={cn(
        'shrink-0 bg-border',
        orientation === 'horizontal' ? 'h-px w-full' : 'h-full w-px',
        className,
      )}
      {...props}
    />
  )
}

export { Separator, type ISeparatorProps }
