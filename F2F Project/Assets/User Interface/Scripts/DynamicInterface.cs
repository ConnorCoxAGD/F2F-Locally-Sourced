using System.Collections.Generic;
using UnityEngine;

public class DynamicInterface : UserInterface
{
    public GameObject inventorySlotPrefab;
    public int columnAmount, xStart, xSpacing, yStart, ySpacing;

    public override void CreateSlots()
    {
        slotsOnInterface = new Dictionary<GameObject, InventorySlot>();
        for (int i = 0; i < inventory.container.items.Length; i++)
        {
            var obj = Instantiate(inventorySlotPrefab, Vector3.zero, Quaternion.identity, transform);
            obj.GetComponent<RectTransform>().localPosition = GetPosition(i);

            slotsOnInterface.Add(obj, inventory.container.items[i]);
        }

        Vector3 GetPosition(int i)
        {
            return new Vector3(xStart + (xSpacing * (i % columnAmount)), yStart + (-ySpacing * (i / columnAmount)), 0f);
        }
    }
}
