import type { ComponentProps } from 'react'

import { cn } from '@/lib/utils'

interface ISkeletonProps extends ComponentProps<'div'> {}

const Skeleton = ({ className, ...props }: ISkeletonProps) => {
  return (
    <div
      data-slot="skeleton"
      className={cn('animate-pulse rounded-md bg-muted', className)}
      {...props}
    />
  )
}

export { Skeleton, type ISkeletonProps }
