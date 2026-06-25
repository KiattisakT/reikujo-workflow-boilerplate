import type { ComponentProps } from 'react'
import { tv, type VariantProps } from 'tailwind-variants'

import { cn } from '@/lib/utils'

const badgeVariants = tv({
  base: 'inline-flex w-fit shrink-0 items-center rounded-md border px-2 py-0.5 text-xs font-medium transition-colors',
  variants: {
    variant: {
      default: 'border-transparent bg-primary text-primary-foreground',
      secondary: 'border-transparent bg-secondary text-secondary-foreground',
      destructive: 'border-transparent bg-destructive text-destructive-foreground',
      outline: 'border-border text-foreground',
      muted: 'border-transparent bg-muted text-muted-foreground',
    },
  },
  defaultVariants: {
    variant: 'default',
  },
})

interface IBadgeVariants extends VariantProps<typeof badgeVariants> {}

interface IBadgeProps extends ComponentProps<'span'>, IBadgeVariants {}

const Badge = ({ className, variant, ...props }: IBadgeProps) => {
  return (
    <span
      data-slot="badge"
      data-variant={variant}
      className={cn(badgeVariants({ variant, className }))}
      {...props}
    />
  )
}

export { Badge, badgeVariants, type IBadgeProps, type IBadgeVariants }
