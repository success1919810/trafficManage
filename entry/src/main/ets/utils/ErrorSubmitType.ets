export enum WorkOrderStatus {
  PENDING = 'pending',
  PROCESSING = 'processing',
  COMPLETED = 'completed',
  EVALUATED = 'evaluated'
}

// 工单数据接口
export interface WorkOrderItem {
  id: number;
  orderNo: string;
  equipmentCode: string;
  equipmentType: string;
  faultType: string;
  location: string;
  reportTime: string;
  reporterName: string;
  status: string;
}

// API响应接口
export interface ApiResponse {
  code: number;
  msg: string;
  data?: object;
}

