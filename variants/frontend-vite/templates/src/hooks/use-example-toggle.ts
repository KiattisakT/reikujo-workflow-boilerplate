import { useCallback, useState } from 'react'

const useExampleToggle = (defaultOpen = false) => {
  // _State
  const [isOpen, setIsOpen] = useState(defaultOpen)

  // _Callback
  const open = useCallback(() => {
    setIsOpen(true)
  }, [])

  const close = useCallback(() => {
    setIsOpen(false)
  }, [])

  const toggle = useCallback(() => {
    setIsOpen((value) => !value)
  }, [])

  return { isOpen, open, close, toggle }
}

export { useExampleToggle }
