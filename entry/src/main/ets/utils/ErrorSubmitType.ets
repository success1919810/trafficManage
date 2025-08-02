export enum WorkOrderStatus {
  PENDING = 'pending',
  PROCESSING = 'processing',
  COMPLETED = 'completed',
  EVALUATED = 'evaluated'
}

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
  responsiblePerson: string;
  contactPhone: string;
  faultDescription: string;
  faultImages: string[];
  maintenancePerson: string;
  processTime: string;
  completeTime: string;
  sceneImages: string[];
  rating: number;
  evaluationComment: string;
  workOrderHistory: WorkOrderHistoryItem[];
}

export interface PageData {
  current: number;
  size: number;
  total: number;
  records: WorkOrderItem[];
}

export interface ApiResponse {
  code: number;
  msg: string;
  data: PageData;
}

//列表处数据体接口
export interface WorkOrderHistoryItem{
  id:number;
  workOrderId:number;
  status:string;
  description:string;
  operatorName:string;
  createdAt:string
}

