export interface IExampleItem {
  id: string
  title: string
  status: 'ready' | 'blocked' | 'done'
}

export interface IExampleListPayload {
  search?: string
}

export interface IExampleListResponse {
  items: IExampleItem[]
  total: number
}
