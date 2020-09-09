using UnityEngine;

[CreateAssetMenu(fileName = "New Enemy Data", menuName = "Scriptables/EnemyData", order = 1)]
public class EnemyData : ScriptableObject {
    [Header("Statistics")] [Range(1, 5)] [Tooltip("Affects health, damage and shield on load.")]
    public float enemyLevel = 1f;

    public float health;
    public float shieldCount;


    [Header("Move")] [Range(4, 12)] public float moveSpeed = 10f;

    [Header("Weapons")] public float crashDamage = 1f;


    private void OnEnable(){
        health = enemyLevel;
        crashDamage = enemyLevel;
        moveSpeed *= enemyLevel;
        shieldCount = enemyLevel - 1f;
    }
}